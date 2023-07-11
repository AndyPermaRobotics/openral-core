import 'package:openral_core/src/model/container.dart';
import 'package:openral_core/src/model/current_geo_location.dart';
import 'package:openral_core/src/model/definition.dart';
import 'package:openral_core/src/model/identity.dart';
import 'package:openral_core/src/model/object_ref.dart';
import 'package:openral_core/src/model/object_template.dart';
import 'package:openral_core/src/model/ral_object.dart';
import 'package:openral_core/src/model/specific_properties.dart';
import 'package:openral_core/src/model/specific_property.dart';
import 'package:test/test.dart';

void main() {
  group(
    RalObject,
    () {
      group(
        'fromMap',
        () {
          test('should return a RalObject with the correct values', () {
            final data = {
              "identity": {
                "UID": "1234",
                "name": "thing",
                "siteTag": "",
                "alternateIDs": ["9876"],
                "alternateNames": ["myName"],
              },
              "currentOwners": [
                {"UID": "ownerUid", "role": "ownerRole"}
              ],
              "definition": {
                "definitionText": "An object or entity that is not or cannot be named specifically",
                "definitionURL": "https://www.thefreedictionary.com/thing"
              },
              "objectState": "undefined",
              "template": {
                "RALType": "thing",
                "version": "1",
                "objectStateTemplates": ["generalObjectState"],
              },
              "specificProperties": [
                {
                  "key": "serial number",
                  "value": "",
                  "unit": "String",
                }
              ],
              "currentGeolocation": {
                "container": {
                  "UID": "unknown",
                },
                "postalAddress": {
                  "country": "unknown",
                  "cityName": "unknown",
                  "cityNumber": "unknown",
                  "streetName": "unknown",
                  "streetNumber": "unknown",
                },
                "3WordCode": "unknown",
                "geoCoordinates": {
                  "longitude": 0,
                  "latitude": 0,
                },
                "plusCode": "unknown"
              },
              "locationHistoryRef": [],
              "ownerHistoryRef": [],
              "methodHistoryRef": [],
              "linkedObjectRef": [
                {"UID": "linkedObjectUid", "role": "linkedObjectRole"}
              ]
            };

            final result = RalObject.fromMap(data);

            expect(result.isLeft, isTrue, reason: result.isRight ? result.right.toString() : null);

            final ralObject = result.left;

            expect(ralObject.identity.uid, equals("1234"));
            expect(ralObject.identity.name, equals("thing"));
            expect(ralObject.identity.siteTag, equals(""));
            expect(ralObject.identity.alternateIDs, equals(["9876"]));
            expect(ralObject.identity.alternateNames, equals(["myName"]));

            expect(ralObject.currentOwners.length, equals(1), reason: "currentOwners should contain one element");
            expect(ralObject.currentOwners[0].uid, equals("ownerUid"));

            expect(ralObject.definition.definitionText, equals("An object or entity that is not or cannot be named specifically"));
            expect(ralObject.definition.definitionURL, equals("https://www.thefreedictionary.com/thing"));

            expect(ralObject.objectState, equals("undefined"));

            expect(ralObject.template.ralType, equals("thing"));
            expect(ralObject.template.version, equals("1"));
            expect(ralObject.template.objectStateTemplates, equals(["generalObjectState"]));

            expect(
              ralObject.specificProperties.containsKey("serial number"),
              isTrue,
              reason: "specificProperties should contain the key 'serial number'",
            );

            expect(ralObject.currentGeoLocation.container!.uid, equals("unknown"));
            //TODO: Other geo location fields

            expect(ralObject.locationHistoryRef, equals([]), reason: "locationHistoryRef should be empty");
            expect(ralObject.ownerHistoryRef, equals([]), reason: "ownerHistoryRef should be empty");
            expect(ralObject.methodHistoryRef, equals([]), reason: "methodHistoryRef should be empty");

            expect(ralObject.linkedObjectRef.length, equals(1), reason: "linkedObjectRef should contain one element");
            expect(ralObject.linkedObjectRef[0].uid, equals("linkedObjectUid"));
          });
        },
      );

      group('toMap', () {
        test('returns map with values', () async {
          //arrange
          final ralObject = RalObject(
            identity: Identity(
              uid: "uid1",
              name: "name1",
              siteTag: "siteTag1",
              alternateIDs: ["alternateID1"],
              alternateNames: ["alternateName1"],
            ),
            currentOwners: [
              ObjectRef(
                uid: 'ownerUid',
                role: 'ownerRole',
              ),
            ],
            definition: Definition(
              definitionText: "definitionText1",
              definitionURL: "definitionURL1",
            ),
            objectState: "objectState1",
            template: ObjectTemplate(
              ralType: "ralType1",
              version: "version1",
              objectStateTemplates: ["objectStateTemplates1"],
            ),
            specificProperties: SpecificProperties({
              "key1": SpecificProperty(
                key: "key1",
                value: "value1",
                unit: "unit1",
              ),
              "key2": SpecificProperty(
                key: "key2",
                value: "value2",
                unit: "unit2",
              ),
            }),
            currentGeoLocation: CurrentGeoLocation(
              container: Container(
                uid: "uid1",
              ),
            ),
            locationHistoryRef: ["locationHistoryRef1"],
            ownerHistoryRef: ["ownerHistoryRef1"],
            methodHistoryRef: ["methodHistoryRef1"],
            linkedObjectRef: [
              ObjectRef(
                uid: 'linkedObjectUid',
                role: 'linkedObjectRole',
              ),
            ],
          );

          //act
          final map = ralObject.toMap();

          //assert
          expect(
            map,
            equals({
              "identity": {
                "UID": "uid1",
                "name": "name1",
                "siteTag": "siteTag1",
                "alternateIDs": ["alternateID1"],
                "alternateNames": ["alternateName1"],
              },
              "currentOwners": [
                {"UID": "ownerUid", "role": "ownerRole"}
              ],
              "definition": {
                "definitionText": "definitionText1",
                "definitionURL": "definitionURL1",
              },
              "objectState": "objectState1",
              "template": {
                "RALType": "ralType1",
                "version": "version1",
                "objectStateTemplates": ["objectStateTemplates1"],
              },
              "specificProperties": [
                {
                  "key": "key1",
                  "value": "value1",
                  "unit": "unit1",
                },
                {
                  "key": "key2",
                  "value": "value2",
                  "unit": "unit2",
                },
              ],
              "currentGeolocation": {
                "container": {
                  "UID": "uid1",
                },
                // uncomment when implemented
                // "postalAddress": {
                //   "country": "unknown",
                //   "cityName": "unknown",
                //   "cityNumber": "unknown",
                //   "streetName": "unknown",
                //   "streetNumber": "unknown",
                // },
                // "3WordCode": "unknown",
                // "geoCoordinates": {
                //   "longitude": 0,
                //   "latitude": 0,
                // },
                // "plusCode": "unknown"
              },
              "locationHistoryRef": ["locationHistoryRef1"],
              "ownerHistoryRef": ["ownerHistoryRef1"],
              "methodHistoryRef": ["methodHistoryRef1"],
              "linkedObjectRef": [
                {
                  "UID": "linkedObjectUid",
                  "role": "linkedObjectRole",
                },
              ],
            }),
          );
        });
      });
    },
  );
}
