import 'package:openral_core/src/discovery/discovery_dimension.dart';
import 'package:openral_core/src/discovery/discovery_v2.dart';
import 'package:openral_core/src/discovery/graph_node.dart';
import 'package:openral_core/src/repository/ral_object_repository.dart';
import 'package:test/test.dart';

import 'mock_data_discovery_v2.dart';

void main() {
  group('DiscoveryV2', () {
    Future<void> checkRelationship(GraphNode parentNode, List<String> expectedChildren, DiscoveryDimension dimension) async {
      List<String> childrenUids = parentNode.children(dimension).map((value) => value.data.identity.uid).toList();

      if (expectedChildren.isEmpty) {
        expect(childrenUids.length, equals(0), reason: "The node ${parentNode.data.identity.uid} should have no children in dimension $dimension");
      } else {
        expect(childrenUids.toSet(), equals(expectedChildren.toSet()),
            reason: "The node ${parentNode.data.identity.uid} should have the children '$expectedChildren' in dimension $dimension");
      }

      for (String childUid in expectedChildren) {
        GraphNode? child = parentNode.getChildWithUid(childUid);
        expect(child, isNotNull, reason: "The node ${parentNode.data.identity.uid} should have the child '$childUid' in dimension $dimension");
        expect(child!.parents(dimension).contains(parentNode), isTrue,
            reason: "The node ${parentNode.data.identity.uid} should be a parent of $childUid in dimension $dimension");
      }
    }

    test('returns a GraphNode with all exected relationships', () async {
      RalObjectRepository ralRepository = MockDataDiscoveryV2.getMockRalRepository();

      DiscoveryV2 discovery = DiscoveryV2(
        ralRepository: ralRepository,
        startObject: await ralRepository.getByUid("Start"),
        rootNodeRalType: "wurzel_type",
        primaryDiscoveryDimension: DiscoveryDimension.containerId,
        discoveryDimensions: [DiscoveryDimension.containerId, DiscoveryDimension.owner, DiscoveryDimension.linkedObjectRef],
      );

      GraphNode wurzel = await discovery.execute();

      expect(wurzel.data.template.ralType, equals("wurzel_type"), reason: "The root node should have the ral type 'wurzel_type'");
      expect(wurzel.data.identity.uid, equals("wurzel"), reason: "The root node should have the uid 'wurzel'");

      await checkRelationship(wurzel, ["A", "B"], DiscoveryDimension.containerId);
      await checkRelationship(wurzel, [], DiscoveryDimension.owner);
      await checkRelationship(wurzel, ["F"], DiscoveryDimension.linkedObjectRef);

      GraphNode? A = wurzel.getChildWithUid("A");
      expect(A, isNotNull, reason: "The root node should have a child with uid 'A'");
      await checkRelationship(A!, ["Start"], DiscoveryDimension.containerId);
      await checkRelationship(A, ["F"], DiscoveryDimension.owner);

      GraphNode? B = wurzel.getChildWithUid("B");
      expect(B, isNotNull, reason: "The root node should have a child with uid 'B'");
      await checkRelationship(B!, ["C"], DiscoveryDimension.containerId);
      await checkRelationship(B, [], DiscoveryDimension.owner);

      GraphNode? F = B.getParentWithUid("F");
      expect(F, isNotNull, reason: "'B' should have a parent with uid 'F'");
      await checkRelationship(F!, [], DiscoveryDimension.containerId);
      await checkRelationship(F, ["B"], DiscoveryDimension.owner);
      await checkRelationship(F, ["wurzel"], DiscoveryDimension.linkedObjectRef);

      GraphNode? Start = A.getChildWithUid("Start");
      expect(Start, isNotNull, reason: "'A' should have a child with uid 'Start'");
      await checkRelationship(Start!, ["D"], DiscoveryDimension.containerId);
      await checkRelationship(Start, ["F"], DiscoveryDimension.owner);

      GraphNode? C = B.getChildWithUid("C");
      expect(C, isNotNull, reason: "'B' should have a child with uid 'C'");
      await checkRelationship(C!, [], DiscoveryDimension.containerId);
      await checkRelationship(C, [], DiscoveryDimension.owner);

      GraphNode? D = Start.getChildWithUid("D");
      expect(D, isNotNull, reason: "'Start' should have a child with uid 'D'");
      await checkRelationship(D!, [], DiscoveryDimension.containerId);
      await checkRelationship(D, [], DiscoveryDimension.owner);
    });
  });
}
