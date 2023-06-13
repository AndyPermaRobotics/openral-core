
from openral_py.discovery.tree_node import TreeNode
from openral_py.model.specific_properties import SpecificProperties
from openral_py.ral_object import RalObject
from openral_py.repository import RalRepository


class Discovery:
    """
    The discovery algorithm goes upward in the RalObject tree until it reaches a RalObject with the given [root_node_ral_type].
    From there it goes downward again. The RalObject with the given [root_node_ral_type] will be the root node of the discovery tree.
    The discovery is started at the [selfObject].
    The result of the discovery is the root node of the discovery tree.
    """

    def __init__(
            self, 
            ral_repository: RalRepository, 
            start_object: RalObject, 
            root_node_ral_type: str
        ):
        self.ral_repository = ral_repository
        """The RAL repository to search for objects."""

        self.self_object = start_object
        """The RAL object to start the discovery from."""

        self.root_node_ral_type = root_node_ral_type
        """The RALType of the desired root node of the discovery tree."""

    async def execute(self) -> TreeNode:
        """
        returns the result of the discovery as the root node of the discovery tree.
        The root node will have the RALType [root_node_ral_type].
        """
        top_node_object = await self._get_root_node_object()
        root_node = TreeNode(data=top_node_object, children=[])
        await self._load_children(root_node)
        return root_node

    async def _load_children(self, node: TreeNode) -> None:
        uid = node.data.identity.uid
        children = await self.ral_repository.get_ral_objects_with_container_id(uid)

        for child in children:
            child_node = node.add_child_with_data(child)
            await self._load_children(child_node)

    async def _get_root_node_object(self) -> RalObject:
        """
        goes the tree upward starting at [start_object] until it reaches a RalObject with the given [root_node_ral_type] and returns it.
        """
        current_object = self.self_object

        while current_object.template.ral_type != self.root_node_ral_type:
            container_id = self._get_container_id_or_fail(current_object)
            current_object = await self.ral_repository.get_ral_object_by_uid(uid=container_id)

        return current_object

    def _get_container_id_or_fail(self, ral_object: RalObject) -> str:
        container = ral_object.current_geo_location.container
        
        container_id = container.uid if container else None

        if container_id is None:
            raise Exception(f"ContainerId of ralObject '{ral_object}' is null.")

        return container_id
