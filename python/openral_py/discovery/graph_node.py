from typing import Any, Dict, List, Optional

from openral_py.discovery.model.discovery_dimension import DiscoveryDimension
from openral_py.model.ral_object import RalObject


class GraphNode:
    """
    Defines a node in graph with different dimensions/relation types.
    The node can be referenced by other nodes=children and can reference other nodes=parents in different dimensions.

    We choose to use a graph instead of a tree, because a RalObject can have multiple parents in different dimensions.
    We still use "chilren" as a term for nodes that are referencing this node and "parents" as a term for nodes that are referenced by this node, because it's easier to distinguish than "refered by" and "referencing".

    """
    def __init__(self, data : RalObject, children_map : Dict[DiscoveryDimension,List['GraphNode']] | None = None, parents_map : Dict[DiscoveryDimension,List['GraphNode']] | None = None):     
        #note: we could use a generic type for data here, but it's not foreseeable that we will need it 
        self.data = data
        #The data of the node. e.g. a RalObject

        #The GraphNodes that are referencing this GraphNode. The GraphNodes are grouped by the dimensions. e.g. if GraphNode B is referencing GraphNode A with DiscoveryDimension.containerId, then children_map[DiscoveryDimension.containerId] contains B.
        self._children_map = children_map or {}

        #The GraphNodes that are referenced by this GraphNode. The GraphNodes are grouped by the dimensions. e.g. if this GraphNode is referencing GraphNode C with DiscoveryDimension.containerId, then parents_map[DiscoveryDimension.containerId] contains C.
        self._parents_map = parents_map or {}


    def add_child_node(self, dimension: DiscoveryDimension, node: "GraphNode"):
        """
        Appends the given node to the children for the given dimension.
    
        """
    
        #todo test
        #if self.data.identity.uid == "wurzel":
        #    print(f"add_child_node {node.data.identity.uid}")


        if dimension not in self._children_map:
            self._children_map[dimension] = [node]
        else:
            self._children_map[dimension].append(node)

        #todo test
        print(f"new children {self.data.identity.uid} {dimension}: {self._children_map[dimension]}")


    def add_parent_node(self, dimension: DiscoveryDimension, node: "GraphNode"):
        """
        Appends the given node to the parents of the given dimension.
        """

        if dimension not in self._parents_map:
            self._parents_map[dimension] = [node]
        else:
            self._parents_map[dimension].append(node)


    def all_children(self) -> List['GraphNode']:
        """
        Returns all GraphNodes that are referencing this GraphNode.
        """
        all_children = []
        for dimension in self._children_map:
            all_children.extend(self._children_map[dimension])
        return all_children

    def children(self, dimension: DiscoveryDimension) -> List['GraphNode']:
        """
        Returns all GraphNodes that are referencing this GraphNode in the given dimension.
        """
        
        if dimension in self._children_map:
            #todo just testing
            print(f"children {self.data.identity.uid} {dimension}: {self._children_map[dimension]}") 
            return self._children_map[dimension]
        
        return []
    
    def all_parents(self) -> List['GraphNode']:
        """
        Returns all GraphNodes that are referenced by this GraphNode.
        """
        referencing = []
        for dimension in self._parents_map:
            referencing.extend(self._parents_map[dimension])
        return referencing
    
    def parents(self, dimension: DiscoveryDimension) -> List['GraphNode']:
        """
        Returns all GraphNodes that are referenced by this GraphNode in the given dimension.
        """
        if dimension in self._parents_map:
            return self._parents_map[dimension]
        
        return []


    def is_root(self, dimension: DiscoveryDimension) -> bool:
        """
        Returns true if the node is not referencing any other node in the given dimension.
        """
        if dimension in self._parents_map:
            return len(self._parents_map[dimension]) == 0
        else:
            return True

    def is_leaf(self, dimension: DiscoveryDimension) -> bool:
        """
        Returns true if the node is not referenced by any other node in the given dimension.
        """
        if dimension in self._children_map:
            return len(self._children_map[dimension]) == 0
        else:
            return True

    def depth(self, dimension: DiscoveryDimension) -> int:
        """
        Returns the depth of the node in the tree for the given dimension.
        Root node has depth 0.
        """
        
        #!we have to pay attention, that we don't run into an infinite loop

        raise NotImplementedError()

        # if self.is_root(dimension):
        #     return 0
        # else:
        #     return self._parent.depth + 1 if self._parent else 0
            
    def get_descendants(self, dimension: DiscoveryDimension) -> List['GraphNode']:
        """
        Returns all descendants of this node in the given dimension. 
        Includes all children, grandchildren, etc.
        """

        #!we have to pay attention here, that we don't run into an infinite loop 
        
        raise NotImplementedError()

        # descendants = []
        # for child in self._children:
        #     descendants.append(child)
        #     descendants.extend(child.get_descendants())
        # return descendants


    def __str__(self) -> str:
        return f"GraphNode(uid={self.data.identity.uid})"
    
    def __repr__(self) -> str:
        return str(self)