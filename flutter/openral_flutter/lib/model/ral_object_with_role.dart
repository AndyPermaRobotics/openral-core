import 'package:openral_flutter/model/current_geo_location.dart';
import 'package:openral_flutter/model/definition.dart';
import 'package:openral_flutter/model/identity.dart';
import 'package:openral_flutter/model/object_ref.dart';
import 'package:openral_flutter/model/ral_object.dart';
import 'package:openral_flutter/model/specific_properties.dart';
import 'package:openral_flutter/model/template.dart';

class RalObjectWithRole extends RalObject {
  final String role;

  RalObjectWithRole({
    required this.role,
    required Identity identity,
    required Definition definition,
    required Template template,
    required SpecificProperties specificProperties,
    required CurrentGeoLocation currentGeolocation,
    List<ObjectRef> currentOwners = const [],
    String objectState = 'undefined',
    List<String> locationHistoryRef = const [],
    List<String> ownerHistoryRef = const [],
    List<String> methodHistoryRef = const [],
    List<ObjectRef> linkedObjectRef = const [],
  }) : super(
          identity: identity,
          definition: definition,
          template: template,
          specificProperties: specificProperties,
          currentGeoLocation: currentGeolocation,
          currentOwners: currentOwners,
          objectState: objectState,
          locationHistoryRef: locationHistoryRef,
          ownerHistoryRef: ownerHistoryRef,
          methodHistoryRef: methodHistoryRef,
          linkedObjectRef: linkedObjectRef,
        );

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['role'] = role;
    return map;
  }

  static RalObjectWithRole fromRalObjectPlusRole(RalObject object, String role) {
    return RalObjectWithRole(
      role: role,
      identity: object.identity,
      definition: object.definition,
      template: object.template,
      specificProperties: object.specificProperties,
      currentGeolocation: object.currentGeoLocation,
      currentOwners: object.currentOwners,
      objectState: object.objectState,
      locationHistoryRef: object.locationHistoryRef,
      ownerHistoryRef: object.ownerHistoryRef,
      methodHistoryRef: object.methodHistoryRef,
      linkedObjectRef: object.linkedObjectRef,
    );
  }

  static RalObjectWithRole fromMap(Map<String, dynamic> map) {
    final result = RalObject.fromMap(map);

    if (result.isRight) {
      throw Exception("Could not parse RalObject from map ${map.toString()}");
    }

    final object = result.left;

    dynamic role = map['role'];

    if (role == null) {
      throw ArgumentError('role is not defined in the map');
    } else if (role is! String) {
      throw ArgumentError('role is not a string');
    } else if (role.isEmpty) {
      throw ArgumentError('role is an empty string');
    }

    return RalObjectWithRole.fromRalObjectPlusRole(object, role);
  }
}
