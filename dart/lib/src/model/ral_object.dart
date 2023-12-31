import 'package:either_dart/either.dart';
import 'package:openral_core/src/cross/backend/parsing/parsing_error.dart';
import 'package:openral_core/src/model/current_geo_location.dart';
import 'package:openral_core/src/model/definition.dart';
import 'package:openral_core/src/model/identity.dart';
import 'package:openral_core/src/model/object_ref.dart';
import 'package:openral_core/src/model/object_template.dart';
import 'package:openral_core/src/model/specific_properties.dart';
import 'package:openral_core/src/model_parser/ral_object_parser.dart';

///represents the base class for RAL objects
///Represents a json object like this:
///```json
/// {
///   "identity": {
///     "UID": "",
///     "name": "thing",
///     "siteTag": "",
///     "alternateIDs": [],
///     "alternateNames": []
///   },
///   "currentOwners": [],
///   "definition": {
///     "definitionText": "An object or entity that is not or cannot be named specifically",
///     "definitionURL": "https://www.thefreedictionary.com/thing"
///   },
///   "objectState": "undefined",
///   "template": {
///     "RALType": "thing",
///     "version": "1",
///     "objectStateTemplates": ["generalObjectState"]
///   },
///   "specificProperties": [
///     {
///       "key": "serial number",
///       "value": "",
///       "unit": "String"
///     }
///   ],
///   "currentGeolocation": {
///     "container": {
///       "UID": "unknown"
///     },
///     "postalAddress": {
///       "country": "unknown",
///       "cityName": "unknown",
///       "cityNumber": "unknown",
///       "streetName": "unknown",
///       "streetNumber": "unknown"
///     },
///     "3WordCode": "unknown",
///     "geoCoordinates": {
///       "longitude": 0,
///       "latitude": 0
///     },
///     "plusCode": "unknown"
///   },
///   "locationHistoryRef": [],
///   "ownerHistoryRef": [],
///   "methodHistoryRef": [],
///   "linkedObjectRef": []
/// }
///
///```
class RalObject<S extends SpecificProperties> {
  //Note: The fields are not final, because otherwise we would have to create a copyWith constructor for every nested field,
  //which would be a lot of boilerplate code

  Identity identity;

  List<ObjectRef> currentOwners;

  Definition definition;

  String objectState;

  ObjectTemplate template;

  S _specificProperties;

  CurrentGeoLocation currentGeoLocation;

  List<String> locationHistoryRef;

  List<String> ownerHistoryRef;

  List<String> methodHistoryRef;

  List<ObjectRef> linkedObjectRef;

  RalObject({
    required this.identity,
    this.currentOwners = const [],
    required this.definition,
    this.objectState = "undefined",
    required this.template,
    required S specificProperties,
    required this.currentGeoLocation,
    this.locationHistoryRef = const [],
    this.ownerHistoryRef = const [],
    this.methodHistoryRef = const [],
    this.linkedObjectRef = const <ObjectRef>[],
  }) : _specificProperties = specificProperties;

  ///by defining a getter, we can override SpecificProperties in subclasses
  S get specificProperties => _specificProperties;

  static Either<RalObject<S>, ParsingError> fromMap<S extends SpecificProperties>(
    Map<String, dynamic> map, {
    S Function(SpecificProperties specificProperties)? specificPropertiesTransform,
  }) {
    final parserFactory = RalObjectParser();

    final parsingResult = parserFactory.fromMap(map);

    if (parsingResult.isRight) {
      //returns the parsing error
      return Right(parsingResult.right);
    } else {
      final originalObject = parsingResult.left;

      if (specificPropertiesTransform != null) {
        //returns the transformed object
        final transformed = originalObject.transformTo<S>(specificPropertiesTransform);

        return Left(transformed);
      } else {
        return Left(parsingResult.left as RalObject<S>);
      }
    }
  }

  ///returns this [RalObject] to a RalObject with the given [SpecificProperties] subclass by using the given [specificPropertiesTransform] function
  RalObject<S> transformTo<S extends SpecificProperties>(
    S Function(SpecificProperties specificProperties) specificPropertiesTransform,
  ) {
    return RalObject<S>(
      identity: identity,
      currentOwners: currentOwners,
      definition: definition,
      objectState: objectState,
      template: template,
      specificProperties: specificPropertiesTransform(specificProperties), //transform the specific properties
      currentGeoLocation: currentGeoLocation,
      locationHistoryRef: locationHistoryRef,
      ownerHistoryRef: ownerHistoryRef,
      methodHistoryRef: methodHistoryRef,
      linkedObjectRef: linkedObjectRef,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "identity": identity.toMap(),
      "currentOwners": currentOwners.map<Map<String, dynamic>>((e) => e.toMap()).toList(),
      "definition": definition.toMap(),
      "objectState": objectState,
      "template": template.toMap(),
      "specificProperties": specificProperties.toMaps(),
      "currentGeolocation": currentGeoLocation.toMap(),
      "locationHistoryRef": locationHistoryRef,
      "ownerHistoryRef": ownerHistoryRef,
      "methodHistoryRef": methodHistoryRef,
      "linkedObjectRef": linkedObjectRef.map<Map<String, dynamic>>((e) => e.toMap()).toList(),
    };
  }
}
