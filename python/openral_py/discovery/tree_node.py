from typing import Any, List, Optional, TypeVar

#todo generic
# T = TypeVar('T')

class TreeNode:
    """
    Defines a node in a tree.
    """
    def __init__(self, 
                 data : Any, 
                 children : List['TreeNode'] = [], 
                 parent : Optional['TreeNode'] = None
            ):
        self.data = data
        self._children = children
        self._parent = parent

    def add_child_with_data(self, child_data: Any):
        """
        Appends a TreeNode with the given [child_data] to the children of this node.
        """
        new_child = TreeNode(child_data, [], self)
        self._children.append(new_child)
        return new_child

    @property
    def children(self) -> List['TreeNode']:
        return self._children

    @property
    def parent(self) -> Optional['TreeNode']:
        return self._parent

    @property
    def is_root(self) -> bool:
        """
        Returns true if the node has no parent.
        """
        return self._parent is None

    @property
    def is_leaf(self) -> bool:
        """
        Returns true if the node has no children.
        """
        return len(self._children) == 0

    @property
    def depth(self) -> int:
        """
        Returns the depth of the node in the tree.
        Root node has depth 0.
        """
        if self.is_root:
            return 0
        else:
            return self._parent.depth + 1 if self._parent else 0
            
    def get_descendants(self) -> List['TreeNode']:
        """
        Returns all descendants of this node. 
        Includes all children, grandchildren, etc.
        """
        descendants = []
        for child in self._children:
            descendants.append(child)
            descendants.extend(child.get_descendants())
        return descendants
