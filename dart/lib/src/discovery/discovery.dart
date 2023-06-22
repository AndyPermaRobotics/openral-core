import 'package:openral_core/src/discovery/discovery_dimension.dart';
import 'package:openral_core/src/discovery/graph_node.dart';
import 'package:openral_core/src/model/ral_object.dart';
import 'package:openral_core/src/repository/ral_object_repository.dart';

///The Discovery Algorithm is used to find all RalObjects that are connected to a given RalObject.
///It starts with an upstream discovery to find the root node of the discovery tree.
///Then it loads the dependencies for every node in the tree recursively by using the given discovery dimensions.
///The result is the root [GraphNode] of the discovery tree with all its dependencies in the different dimensions.
class Discovery {
  /// The RAL repository to search for objects.
  final RalObjectRepository ralRepository;

  /// The [RalObject] to start the discovery from.
  final RalObject startObject;

  // The RALType of the desired root node of the discovery tree.
  final String rootNodeRalType;

  /// The primary dimension is used to go upward in the RalObject tree first to find the root node.
  /// IMPORTANT: The primary dimension must be a tree dimension, so every RalObject has only one parent. e.g. container.UID
  final DiscoveryDimension primaryDiscoveryDimension;

  /// The dimensions that are used for the discovery. e.g. container.UID, owners, linkedObjectRef
  final List<DiscoveryDimension> discoveryDimensions;

  ///used to store the already loaded objects to avoid loading them twice
  final Map<String, GraphNode> _objectRegistry = {};

  Discovery({
    required this.ralRepository,
    required this.startObject,
    required this.rootNodeRalType,
    required this.primaryDiscoveryDimension,
    this.discoveryDimensions = const [],
  }) {
    // at the moment only containerId is supported as primary discovery dimension, because it's a tree dimension and every RalObject has only one parent
    if (primaryDiscoveryDimension != DiscoveryDimension.containerId) {
      throw Exception("The primary discovery dimension must be ${DiscoveryDimension.containerId}.");
    }
  }

  Future<GraphNode> execute() async {
    // first of all we iterate upward until we reach the root node
    final topNodeObject = await _getRootNodeObject();
    final rootNode = GraphNode(data: topNodeObject);

    // add the root node to the registry
    _objectRegistry[topNodeObject.identity.uid] = rootNode;

    // then we load the children recursively starting with the root node
    await _loadDependenciesForNodeRecursively(rootNode);

    return rootNode;
  }

  Future<void> _loadDependenciesForNodeRecursively(GraphNode node) async {
    List<GraphNode> allNewNodes = [];

    // collect the children and parents for every dimension
    for (final dimension in discoveryDimensions) {
      if (dimension == DiscoveryDimension.containerId) {
        final ralObjects = await _getChildrenForDimension(node.data, dimension);

        final newNodes = _integrateObjects(ralObjects, node, dimension, asChild: true);

        allNewNodes.addAll(newNodes);
      } else if (dimension == DiscoveryDimension.owner) {
        final ralObjects = await _getParentsForDimension(node.data, dimension);

        final newNodes = _integrateObjects(ralObjects, node, dimension, asChild: false);

        allNewNodes.addAll(newNodes);
      } else if (dimension == DiscoveryDimension.linkedObjectRef) {
        final ralObjects = await _getChildrenForDimension(node.data, dimension);

        final newNodes = _integrateObjects(ralObjects, node, dimension, asChild: true);

        allNewNodes.addAll(newNodes);
      } else {
        throw Exception("Dimension $dimension is not supported yet.");
      }
    }

    print("Loaded new nodes: $allNewNodes by loading dependencies for node: $node");

    // for every new node we have to load the dependencies recursively
    for (var newNode in allNewNodes) {
      await _loadDependenciesForNodeRecursively(newNode);
    }
  }

  List<GraphNode> _integrateObjects(List<RalObject> ralObjects, GraphNode currentNode, DiscoveryDimension dimension, {required bool asChild}) {
    /*
      Iterates over all given objects and adds them to the currentNode as children for the given dimension.
        
      Creates new GraphNodes for the ralObjects if they are not already in the registry and returns all new GraphNodes.
    */

    print("Integrate ${ralObjects.map((e) => e.identity.uid).toList()} with $dimension into $currentNode");

    List<GraphNode> newNodes = [];

    late GraphNode graphNode;

    for (final ralObject in ralObjects) {
      // look if there is already a node in the registry
      if (_objectRegistry.containsKey(ralObject.identity.uid)) {
        graphNode = _objectRegistry[ralObject.identity.uid]!;
      } else {
        graphNode = GraphNode(data: ralObject);
        _objectRegistry[ralObject.identity.uid] = graphNode;

        newNodes.add(graphNode);
      }

      if (asChild) {
        graphNode.addParentNode(dimension, currentNode);
        currentNode.addChildNode(dimension, graphNode);
      } else {
        graphNode.addChildNode(dimension, currentNode);
        currentNode.addParentNode(dimension, graphNode);
      }
    }

    return newNodes;
  }

  Future<RalObject> _getRootNodeObject() async {
    /*
      goes the tree upward starting at startObject until it reaches a RalObject with the given rootNodeRalType and returns it.
    */
    var currentObject = startObject;

    while (currentObject.template.ralType != rootNodeRalType) {
      var ralObjects = await _getParentsForDimension(currentObject, primaryDiscoveryDimension);

      if (ralObjects.isEmpty) {
        throw Exception("RootNodeDiscovery failed: RalObject '$currentObject' has no parent with dimension '$primaryDiscoveryDimension'.");
      }

      if (ralObjects.length > 1) {
        throw Exception(
            "RootNodeDiscovery failed: RalObject '$currentObject' has more than one parent with dimension '$primaryDiscoveryDimension'. This is not supported for the RootNodeDiscovery.");
      }

      currentObject = ralObjects[0];
    }

    return currentObject;
  }

  Future<List<RalObject>> _getChildrenForDimension(RalObject ralObject, DiscoveryDimension dimension) async {
    /*
       Returns the RalObjects that are referencing the given RalObject in the given dimension.
       e.g. if the dimension is DiscoveryDimension.containerId, then all RalObjects that have the given RalObject as container will be returned.
    */
    if (dimension == DiscoveryDimension.containerId) {
      return await ralRepository.getByContainerId(ralObject.identity.uid);
    } else if (dimension == DiscoveryDimension.linkedObjectRef) {
      final linkedObjRef = ralObject.linkedObjectRef;

      final ralObjects = <RalObject>[];
      for (final ref in linkedObjRef) {
        final ralObject = await ralRepository.getByUid(ref.uid);
        ralObjects.add(ralObject);
      }

      return ralObjects;
    } else {
      throw Exception("Dimension $dimension is not supported to find children yet.");
    }
  }

  Future<List<RalObject>> _getParentsForDimension(RalObject ralObject, DiscoveryDimension dimension) async {
    /*
      Returns the RalObjects that are referenced by the given RalObject in the given dimension.
      e.g. if ralObject has some owners and dimension is DiscoveryDimension.owner, then the owners will be returned.
    */
    if (dimension == DiscoveryDimension.containerId) {
      var object = await _getParentByContainerId(ralObject);

      return [object]; // there is only one object for the containerId dimension
    } else if (dimension == DiscoveryDimension.owner) {
      // iterate over the owners and load the RalObjects

      var owners = ralObject.currentOwners;

      var ralObjects = <RalObject>[];
      for (var owner in owners) {
        var ralObject = await ralRepository.getByUid(owner.uid);
        ralObjects.add(ralObject);
      }

      return ralObjects;
    } else {
      throw Exception("Dimension $dimension is not supported to find parents yet.");
    }
  }

  Future<RalObject> _getParentByContainerId(RalObject ralObject) async {
    /*
      Returns the parent of the given RalObject by using the containerId dimension.
    */

    var containerId = _getContainerIdOrFail(ralObject);

    return await ralRepository.getByUid(containerId);
  }

  String _getContainerIdOrFail(RalObject ralObject) {
    var container = ralObject.currentGeoLocation.container;

    var containerId = container?.uid;

    if (containerId == null) {
      throw Exception("ContainerId of ralObject '$ralObject' is null.");
    }

    return containerId;
  }
}
