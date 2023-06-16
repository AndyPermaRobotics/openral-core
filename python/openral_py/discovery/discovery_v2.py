
from typing import Dict, List

from openral_py.discovery.model.discovery_dimension import DiscoveryDimension
from openral_py.model.ral_object import RalObject
from openral_py.model.specific_properties import SpecificProperties
from openral_py.repository.ral_object_repository import RalObjectRepository

from python.openral_py.discovery.graph_node import GraphNode


class DiscoveryV2:
    """
    The discovery algorithm goes upward in the RalObject tree using the [primary_discovery_dimension] until it reaches a RalObject with the given [root_node_ral_type].
    From there it goes downward again. The RalObject with the given [root_node_ral_type] will be the root node of the discovery tree.
    The discovery is started at the [selfObject].
    The result of the discovery is the root node of the discovery tree.
    """

    def __init__(
            self, 
            ral_repository: RalObjectRepository, 
            start_object: RalObject, 
            root_node_ral_type: str,
            primary_discovery_dimension: DiscoveryDimension,
            discovery_dimensions: List[DiscoveryDimension] = []
        ):

        if(primary_discovery_dimension is not DiscoveryDimension.containerId ):
            raise Exception(f"The primary discovery dimension must be {DiscoveryDimension.containerId}.")
            # at the moment only containerId is supported as primary discovery dimension, because it's a tree dimension and every RalObject has only one parent

        self.primary_discovery_dimension = primary_discovery_dimension
        """The primary dimension is used to go upward in the RalObject tree first to find the root node. IMPORTANT: The primary dimension must be a tree dimension, so every RalObject has only one parent. e.g. container.UID"""


        self.discovery_dimensions = discovery_dimensions
        """The dimensions that are used for the discovery. e.g. container.UID, owners, linkedObjectRef"""


        self.ral_repository = ral_repository
        """The RAL repository to search for objects."""

        self.self_object = start_object
        """The RAL object to start the discovery from."""

        self.root_node_ral_type = root_node_ral_type
        """The RALType of the desired root node of the discovery tree."""

        self._object_registry : Dict[str, GraphNode] = {}
        """A registry of GraphNodes for RalObjects. The key is the UID of the RalObject. This is used to avoid loading the same Node multiple times."""


    async def execute(self) -> GraphNode:
        """
        returns the result of the discovery as the root node of the discovery tree.
        The root node will have the RALType [root_node_ral_type].
        """

        #first of all we iterate upward until we reach the root node
        top_node_object = await self._get_root_node_object()
        root_node = GraphNode(data=top_node_object)

        # add the root node to the registry
        self._object_registry[top_node_object.identity.uid] = root_node

        #then we load the children recursively starting with the root node
        await self._load_dependencies_for_node_recursively(root_node)
    
        return root_node

    async def _load_dependencies_for_node_recursively(self, node: GraphNode) -> None:
       
        
        all_new_nodes : List[GraphNode] = []

        # collect the children and parents for every dimension
        for dimension in self.discovery_dimensions:
            if(dimension is DiscoveryDimension.containerId):
                ral_objects = await self._get_children_for_dimension(node.data, dimension)
                
                new_nodes = self._integrate_objects(ral_objects, node, dimension, as_child=True)

                all_new_nodes.extend(new_nodes)

            if(dimension is DiscoveryDimension.owner):

                ral_objects = await self._get_parents_for_dimension(node.data, dimension)

                new_nodes = self._integrate_objects(ral_objects, node, dimension, as_child=False)

                all_new_nodes.extend(new_nodes)

            else:
                # todo implement the other dimensions

                raise Exception(f"Dimension {dimension} is not supported yet.")
        

        # for every new node we have to load the dependencies recursively
        for new_node in all_new_nodes:
            await self._load_dependencies_for_node_recursively(new_node)
       
       
    def _integrate_objects(
            self, 
            ral_objects: List[RalObject], 
            current_node: GraphNode, 
            dimension: DiscoveryDimension,
            as_child: bool, # if false the objects will be added as parents
            ) -> List[GraphNode]:
        """
        Iterates over all given objects and adds them to the current_node as children for the given dimension.
        
        Creates new GraphNodes for the ral_objects if they are not already in the registry and returns all new GraphNodes.
        """

        new_nodes : List[GraphNode] = []

        for ral_object in ral_objects:
            # look if there is already a node in the registry
            if ral_object.identity.uid in self._object_registry:
                graph_node = self._object_registry[ral_object.identity.uid]
            else:
                graph_node = GraphNode(data=ral_object)
                self._object_registry[ral_object.identity.uid] = graph_node
    
                new_nodes.append(graph_node)

            if(as_child):
                current_node.add_child_node(dimension, graph_node)
            else:
                current_node.add_parent_node(dimension, graph_node)

        return new_nodes


    async def _get_root_node_object(self) -> RalObject:
        """
        goes the tree upward starting at [start_object] until it reaches a RalObject with the given [root_node_ral_type] and returns it.
        """
        current_object = self.self_object

        while current_object.template.ral_type != self.root_node_ral_type:
            
            ral_objects = await self._get_parents_for_dimension( 
                current_object, 
                dimension = self.primary_discovery_dimension
            )

            if(len(ral_objects) == 0):
                raise Exception(f"RootNodeDiscovery failed: RalObject '{current_object}' has no parent with dimension '{self.primary_discovery_dimension}'.")
            
            if(len(ral_objects) > 1):
                raise Exception(f"RootNodeDiscovery failed: RalObject '{current_object}' has more than one parent with dimension '{self.primary_discovery_dimension}'. This is not supported for the RootNodeDiscovery.")

            current_object = ral_objects[0]            

        return current_object


    async def _get_children_for_dimension(self, ral_object: RalObject, dimension: DiscoveryDimension) -> List[RalObject]:
        """
        Returns the RalObjects that are referencing the given RalObject in the given dimension.
        e.g. if the dimension is DiscoveryDimension.containerId, then all RalObjects that have the given RalObject as container will be returned.
        """
        if(dimension == DiscoveryDimension.containerId):
            return await self.ral_repository.get_by_container_id(ral_object.identity.uid)

        else:
            raise Exception(f"Dimension {dimension} is not supported to find children yet.")


    async def _get_parents_for_dimension(self, ral_object: RalObject, dimension: DiscoveryDimension) -> List[RalObject]:
        """
        Returns the RalObjects that are referenced by the given RalObject in the given dimension.
        e.g. if ral_object has some owners and dimension is DiscoveryDimension.owner, then the owners will be returned.
        """
        
        if(dimension == DiscoveryDimension.containerId):
            object = await self._get_parent_by_container_id(ral_object)

            return [object] # there is only one object for the containerId dimension

        elif(dimension == DiscoveryDimension.owner):
            # iterate over the owners and load the RalObjects

            owners = ral_object.current_owners

            ral_objects = []
            for owner in owners:
                ral_object = await self.ral_repository.get_by_uid(owner.uid)
                ral_objects.append(ral_object)

            return ral_objects

        else:
            raise Exception(f"Dimension {dimension} is not supported to find parents yet.")


    async def _get_parent_by_container_id(self, ral_object: RalObject) -> RalObject:
        """
        Returns the parent of the given RalObject by using the containerId dimension.
        """

        container_id = self._get_container_id_or_fail(ral_object)

        return await self.ral_repository.get_by_uid(uid=container_id)


    def _get_container_id_or_fail(self, ral_object: RalObject) -> str:
        container = ral_object.current_geo_location.container
        
        container_id = container.uid if container else None

        if container_id is None:
            raise Exception(f"ContainerId of ralObject '{ral_object}' is null.")

        return container_id
