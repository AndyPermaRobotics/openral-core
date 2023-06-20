import 'dart:async';

import 'package:openral_flutter/model/ral_object.dart';
import 'package:openral_flutter/model/specific_properties.dart';
import 'package:openral_flutter/repository/ral_object_repository.dart';

//todo generics
class MockRalObjectRepository<S extends SpecificProperties> extends RalObjectRepository {
  /*
  A mock implementation of [RalRepository] that stores [RalObject]s in memory.
  */
  final Map<String, Map<String, dynamic>> docsByUid;
  final Map<String, List<String>> docsByContainerId;

  MockRalObjectRepository({
    required this.docsByUid,
    required this.docsByContainerId,
  });

  @override
  Future<RalObject> getByUid(String uid, {SpecificPropertiesTransform? specificPropertiesTransform}) async {
    final doc = docsByUid[uid];

    if (doc == null) {
      throw Exception("No RalObject found for uid '$uid'");
    }

    final parsingResult = RalObject.fromMap(doc);

    if (parsingResult.isRight) {
      throw Exception("Error parsing RalObject with uid '$uid': ${parsingResult.right}");
    }

    final ralObject = parsingResult.left;

    return ralObject;
  }

  @override
  Future<List<RalObject>> getByContainerId(String containerId) async {
    final uids = docsByContainerId[containerId];

    if (uids == null) {
      return [];
    }

    final result = <RalObject>[];

    for (final uid in uids) {
      final object = await getByUid(uid);
      result.add(object);
    }

    return result;
  }

  @override
  Future<List<RalObject>> getByRalType(String ralType) async {
    final result = <RalObject>[];

    for (final uid in docsByUid.keys) {
      final object = await getByUid(uid);

      if (object.template.ralType == ralType) {
        result.add(object);
      }
    }

    return result;
  }

  @override
  Future<void> create(RalObject ralObject, {bool overrideIfExists = false}) async {
    if (!overrideIfExists && docsByUid.containsKey(ralObject.identity.uid)) {
      throw Exception("RalObject with uid '${ralObject.identity.uid}' already exists.");
    }

    docsByUid[ralObject.identity.uid] = ralObject.toMap();

    // add the uid to docsByContainerId if it has a container.UID
    final container = ralObject.currentGeoLocation.container;
    if (container != null) {
      final containerId = container.uid;

      final docs = docsByContainerId[containerId];

      if (docs == null) {
        docsByContainerId[containerId] = [];
      } else if (docs.contains(ralObject.identity.uid) == false) {
        docsByContainerId[containerId]!.add(ralObject.identity.uid);
      }
    }
  }
}
