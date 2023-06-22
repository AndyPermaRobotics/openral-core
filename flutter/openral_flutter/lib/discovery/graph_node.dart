import 'package:openral_flutter/discovery/discovery_dimension.dart';
import 'package:openral_flutter/model/ral_object.dart';

class GraphNode {
  RalObject data;
  final Map<DiscoveryDimension, List<GraphNode>> _childrenMap;
  final Map<DiscoveryDimension, List<GraphNode>> _parentsMap;

  GraphNode({
    required this.data,
    Map<DiscoveryDimension, List<GraphNode>>? childrenMap,
    Map<DiscoveryDimension, List<GraphNode>>? parentsMap,
  })  : _childrenMap = childrenMap ?? {},
        _parentsMap = parentsMap ?? {};

  void addChildNode(
    DiscoveryDimension dimension,
    GraphNode node,
  ) {
    if (!_childrenMap.containsKey(dimension)) {
      _childrenMap[dimension] = [node];
    } else {
      _childrenMap[dimension]!.add(node);
    }
  }

  void addParentNode(
    DiscoveryDimension dimension,
    GraphNode node,
  ) {
    if (!_parentsMap.containsKey(dimension)) {
      _parentsMap[dimension] = [node];
    } else {
      _parentsMap[dimension]!.add(node);
    }
  }

  List<GraphNode> allChildren() {
    return _childrenMap.values.expand((nodes) => nodes).toList();
  }

  List<GraphNode> children(DiscoveryDimension dimension) {
    return _childrenMap.containsKey(dimension) ? _childrenMap[dimension]! : [];
  }

  List<GraphNode> allParents() {
    return _parentsMap.values.expand((nodes) => nodes).toList();
  }

  List<GraphNode> parents(DiscoveryDimension dimension) {
    return _parentsMap.containsKey(dimension) ? _parentsMap[dimension]! : [];
  }

  bool isRoot(DiscoveryDimension dimension) {
    return _parentsMap.containsKey(dimension) ? _parentsMap[dimension]!.isEmpty : true;
  }

  bool isLeaf(DiscoveryDimension dimension) {
    return _childrenMap.containsKey(dimension) ? _childrenMap[dimension]!.isEmpty : true;
  }

  int depth(DiscoveryDimension dimension) {
    // we have to pay attention, that we don't run into an infinite loop
    throw UnimplementedError();

    // if (isRoot(dimension)) {
    //   return 0;
    // } else {
    //   return _parent.depth + 1 ?? 0;
    // }
  }

  // List<GraphNode> getDescendants(DiscoveryDimension dimension) {
  //   // we have to pay attention here, that we don't run into an infinite loop
  //   throw UnimplementedError();

  //   // List<GraphNode> descendants = [];
  //   // for (GraphNode child in _children) {
  //   //   descendants.add(child);
  //   //   descendants.addAll(child.getDescendants());
  //   // }
  //   // return descendants;
  // }

  @override
  String toString() {
    return 'GraphNode(uid=${data.identity.uid})';
  }

  String toTreeString({
    int depth = 0,
  }) {
    String result = '';
    for (int i = 0; i < depth; i++) {
      result += '  ';
    }
    result += data.identity.uid;

    result += '\n';
    for (GraphNode child in allChildren()) {
      result += child.toTreeString(depth: depth + 1);
    }
    return result;
  }

  GraphNode? getChildWithUid(
    String uid, {
    DiscoveryDimension? dimension,
  }) {
    if (dimension == null) {
      for (DiscoveryDimension dim in _childrenMap.keys) {
        for (GraphNode child in _childrenMap[dim]!) {
          if (child.data.identity.uid == uid) {
            return child;
          }
        }
      }
    } else {
      for (GraphNode child in children(dimension)) {
        if (child.data.identity.uid == uid) {
          return child;
        }
      }
    }
    return null;
  }

  GraphNode? getParentWithUid(
    String uid, {
    DiscoveryDimension? dimension,
  }) {
    if (dimension == null) {
      for (DiscoveryDimension dim in _parentsMap.keys) {
        for (GraphNode parent in _parentsMap[dim]!) {
          if (parent.data.identity.uid == uid) {
            return parent;
          }
        }
      }
    } else {
      for (GraphNode parent in parents(dimension)) {
        if (parent.data.identity.uid == uid) {
          return parent;
        }
      }
    }
    return null;
  }
}
