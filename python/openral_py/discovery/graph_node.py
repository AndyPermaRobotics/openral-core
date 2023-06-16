from typing import Any, Dict, List, Optional

from openral_py.discovery.model.discovery_dimension import DiscoveryDimension


class GraphNode:
    """
    Defines a node in graph with different dimensions/relation types.
    The node can be referenced by other nodes and can reference other nodes in different dimensions.
    """
    def __init__(self, 
                 data : Any, 
                 referencedByMap : Dict[DiscoveryDimension,List['GraphNode']] = {}, 
                 referencingMap : Dict[DiscoveryDimension,List['GraphNode']] = {}
            ):
        self.data = data
        """The data of the node. e.g. a RalObject"""

        #todo: 'children' and 'parent' are not the best names. Because it must not be a hierarchical tree for every dimension. Its more like 

        self._referencedByMap = referencedByMap
        """The GraphNodes that are referencing this GraphNode. The GraphNodes are grouped by the dimensions. e.g. if GraphNode B is referencing GraphNode A with DiscoveryDimension.containerId, then referencedByMap[DiscoveryDimension.containerId] contains B."""

        self._referencingMap = referencingMap
        """The GraphNodes that are referenced by this GraphNode. The GraphNodes are grouped by the dimensions. e.g. if this GraphNode is referencing GraphNode C with DiscoveryDimension.containerId, then referencingMap[DiscoveryDimension.containerId] contains C."""

    def add_referenced_by_node(self, dimension: DiscoveryDimension, node: "GraphNode"):
        """
        Appends the given node to the _referencedByMap map.
        """
    
        if dimension not in self._referencedByMap:
            self._referencedByMap[dimension] = [node]
        else:
            self._referencedByMap[dimension].append(node)

    def add_referencing_node(self, dimension: DiscoveryDimension, node: "GraphNode"):
        """
        Appends the given node to the _referencingMap map.
        """

        if dimension not in self._referencingMap:
            self._referencingMap[dimension] = [node]
        else:
            self._referencingMap[dimension].append(node)


    def all_referenced_by(self) -> List['GraphNode']:
        """
        Returns all GraphNodes that are referencing this GraphNode.
        """
        referenced_by = []
        for dimension in self._referencedByMap:
            referenced_by.extend(self._referencedByMap[dimension])
        return referenced_by

    def referenced_by(self, dimension: DiscoveryDimension) -> List['GraphNode']:
        """
        Returns all GraphNodes that are referencing this GraphNode in the given dimension.
        """
        
        if dimension in self._referencedByMap:
            return self._referencedByMap[dimension]
        
        return []
    
    def all_referencing(self) -> List['GraphNode']:
        """
        Returns all GraphNodes that are referenced by this GraphNode.
        """
        referencing = []
        for dimension in self._referencingMap:
            referencing.extend(self._referencingMap[dimension])
        return referencing
    
    def referencing(self, dimension: DiscoveryDimension) -> List['GraphNode']:
        """
        Returns all GraphNodes that are referenced by this GraphNode in the given dimension.
        """
        if dimension in self._referencingMap:
            return self._referencingMap[dimension]
        
        return []


    def is_root(self, dimension: DiscoveryDimension) -> bool:
        """
        Returns true if the node is not referencing any other node in the given dimension.
        """
        if dimension in self._referencingMap:
            return len(self._referencingMap[dimension]) == 0
        else:
            return True

    def is_leaf(self, dimension: DiscoveryDimension) -> bool:
        """
        Returns true if the node is not referenced by any other node in the given dimension.
        """
        if dimension in self._referencedByMap:
            return len(self._referencedByMap[dimension]) == 0
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
