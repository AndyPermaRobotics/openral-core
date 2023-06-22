
from typing import List

import pytest
from openral_py.discovery.discovery import Discovery
from openral_py.discovery.graph_node import GraphNode
from openral_py.discovery.model.discovery_dimension import DiscoveryDimension
from tests.discovery.mock_data_discovery_v2 import MockDataDiscoveryV2


class TestDiscovery:
    
    def check_relationship(self, parent_node: GraphNode, expected_children: List[str], dimension: DiscoveryDimension):
        """
        Bidirectional check of the relationship between the given parent node and the given children.
        Checks if the given node has the given children in the given dimension.
        And that the given children have the given node as parent in the given dimension.
        """

        children_uids = [value.data.identity.uid for value in parent_node.children(dimension)]

        #check children of parent node
        if len(expected_children) == 0:
            assert len(children_uids) == 0, f"The node {parent_node.data.identity.uid} should have no children in dimension {dimension}"
        else:
            assert set(children_uids) == set(expected_children), f"The node {parent_node.data.identity.uid} should have the children '{expected_children}' in dimension {dimension}"

        #check parent of each child
        for child_uid in expected_children:
            child = parent_node.get_child_with_uid(child_uid)
            assert child is not None, f"The node {parent_node.data.identity.uid} should have the child '{child_uid}' in dimension {dimension}"
            assert parent_node in child.parents(dimension), f"The node {parent_node.data.identity.uid} should be a parent of {child_uid} in dimension {dimension}"


    @pytest.mark.asyncio
    async def test_discovery(self):
        """
        Tests the discovery algorithm with a mock repository.
        """

        # Arrange
        ral_repository = MockDataDiscoveryV2.getMockRalRepository()

        # Act
        discovery = Discovery(
            ral_repository= ral_repository,
            start_object= await ral_repository.get_by_uid("Start"),
            root_node_ral_type= "wurzel_type", #we want to find the root node of the tree that has this ral type
            primary_discovery_dimension = DiscoveryDimension.containerId,
            discovery_dimensions = [DiscoveryDimension.containerId,DiscoveryDimension.owner, DiscoveryDimension.linkedObjectRef]
        )

        wurzel = await discovery.execute()

        # Assert
        assert wurzel.data.template.ral_type == "wurzel_type", "The root node should have the ral type 'wurzel_type'"
        assert wurzel.data.identity.uid == "wurzel", "The root node should have the uid 'wurzel'"

        # Check root node
        self.check_relationship(wurzel, ["A","B"], DiscoveryDimension.containerId)
        self.check_relationship(wurzel, [], DiscoveryDimension.owner)
        self.check_relationship(wurzel, ["F"], DiscoveryDimension.linkedObjectRef)


        # check children of root node
        A = wurzel.get_child_with_uid("A")
        assert A is not None, "The root node should have a child with uid 'A'"
        self.check_relationship(A, ["Start"], DiscoveryDimension.containerId)
        self.check_relationship(A, ["F"], DiscoveryDimension.owner)


        B = wurzel.get_child_with_uid("B")
        assert B is not None, "The root node should have a child with uid 'B'"        
        self.check_relationship(B, ["C"], DiscoveryDimension.containerId)
        self.check_relationship(B, [], DiscoveryDimension.owner)
         
        
        F = B.get_parent_with_uid("F")
        assert F is not None, "'B' should have a parent with uid 'F'"
        self.check_relationship(F, [], DiscoveryDimension.containerId)
        self.check_relationship(F, ["B"], DiscoveryDimension.owner)
        self.check_relationship(F, ["wurzel"], DiscoveryDimension.linkedObjectRef)

        Start = A.get_child_with_uid("Start")
        assert Start is not None, "'A' should have a child with uid 'Start'"
        self.check_relationship(Start, ["D"], DiscoveryDimension.containerId)
        self.check_relationship(Start, ["F"], DiscoveryDimension.owner)

        C = B.get_child_with_uid("C")
        assert C is not None, "'B' should have a child with uid 'C'"
        self.check_relationship(C, [], DiscoveryDimension.containerId)
        self.check_relationship(C, [], DiscoveryDimension.owner)

        D = Start.get_child_with_uid("D")
        assert D is not None, "'Start' should have a child with uid 'D'"
        self.check_relationship(D, [], DiscoveryDimension.containerId)
        self.check_relationship(D, [], DiscoveryDimension.owner)
