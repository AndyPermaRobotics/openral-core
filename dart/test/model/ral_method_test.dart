import 'package:openral_core/openral_core.dart';
import 'package:test/test.dart';

void main() {
  group(RalMethod, () {
    group(
      'fromMap',
      () {
        test('should return a RalMethod with the correct values', () {
          final data = {
            "definition": {
              "definitionText": "myDefinitionText",
              "definitionURL": "",
            },
            "existenceStarts": null,
            "duration": null,
            "identity": {
              "UID": "myUID",
              "name": "",
              "siteTag": "",
              "alternateIDs": [],
              "alternateNames": [],
            },
            "methodState": "undefined",
            "template": {
              "RALType": "myMethodTemplate",
              "version": "1",
              "methodStateTemplates": ["generalMethodState"]
            },
            "specificProperties": [
              {"key": "myKey", "value": "myValue", "unit": "myUnit"}
            ],
            "inputObjects": [
              {
                "role": "specialRoleForMethod", //the role is important for the inputObjects of a RalMethod
                "identity": {
                  "UID": "myNestedInputUid",
                  "name": "thing",
                  "siteTag": "",
                  "alternateIDs": [],
                  "alternateNames": [],
                },
                "currentOwners": [],
                "definition": {
                  "definitionText": "An object or entity that is not or cannot be named specifically",
                  "definitionURL": "https://www.thefreedictionary.com/thing"
                },
                "objectState": "undefined",
                "template": {
                  "RALType": "thing",
                  "version": "1",
                  "objectStateTemplates": ["generalObjectState"]
                },
                "specificProperties": [
                  {"key": "serial number", "value": "", "unit": "String"}
                ],
                "currentGeolocation": {
                  "container": {"UID": "unknown"},
                  "postalAddress": {"country": "unknown", "cityName": "unknown", "cityNumber": "unknown", "streetName": "unknown", "streetNumber": "unknown"},
                  "3WordCode": "unknown",
                  "geoCoordinates": {"longitude": 0, "latitude": 0},
                  "plusCode": "unknown"
                },
                "locationHistoryRef": [],
                "ownerHistoryRef": [],
                "methodHistoryRef": [],
                "linkedObjectRef": []
              }
            ],
            "inputObjectsRef": [
              {"UID": "inputRefUID", "role": "myRole"},
            ],
            "outputObjects": [
              {
                "identity": {"UID": "myNestedOutputUid", "name": "thing", "siteTag": "", "alternateIDs": [], "alternateNames": []},
                "currentOwners": [],
                "definition": {
                  "definitionText": "An object or entity that is not or cannot be named specifically",
                  "definitionURL": "https://www.thefreedictionary.com/thing"
                },
                "objectState": "undefined",
                "template": {
                  "RALType": "thing",
                  "version": "1",
                  "objectStateTemplates": ["generalObjectState"]
                },
                "specificProperties": [
                  {"key": "serial number", "value": "", "unit": "String"}
                ],
                "currentGeolocation": {
                  "container": {"UID": "unknown"},
                  "postalAddress": {"country": "unknown", "cityName": "unknown", "cityNumber": "unknown", "streetName": "unknown", "streetNumber": "unknown"},
                  "3WordCode": "unknown",
                  "geoCoordinates": {"longitude": 0, "latitude": 0},
                  "plusCode": "unknown"
                },
                "locationHistoryRef": [],
                "ownerHistoryRef": [],
                "methodHistoryRef": [],
                "linkedObjectRef": []
              }
            ],
            "outputObjectsRef": [
              {
                "UID": "outputRefUID",
                "role": "myRole",
              }
            ],
            "nestedMethods": [
              {
                "definition": {"definitionText": "", "definitionURL": ""},
                "existenceStarts": null,
                "duration": null,
                "identity": {
                  "UID": "myNestedUid",
                  "name": "",
                  "siteTag": "",
                  "alternateIDs": [],
                  "alternateNames": [],
                },
                "methodState": "undefined",
                "template": {
                  "RALType": "myMethodTemplate",
                  "version": "1",
                  "methodStateTemplates": ["generalMethodState"],
                },
                "specificProperties": [
                  {"key": "myKey", "value": "myValue", "unit": "myUnit"}
                ],
                "inputObjects": [],
                "inputObjectsRef": [
                  {"UID": "inputRefUID", "role": "myRole"},
                ],
                "outputObjects": [],
                "outputObjectsRef": [
                  {"UID": "outputRefUID", "role": "myRole"}
                ],
                "nestedMethods": []
              }
            ],
            "executor": {
              "identity": {
                "UID": "myExecutorUid",
                "name": "thing",
                "siteTag": "",
                "alternateIDs": [],
                "alternateNames": [],
              },
              "currentOwners": [],
              "definition": {
                "definitionText": "An object or entity that is not or cannot be named specifically",
                "definitionURL": "https://www.thefreedictionary.com/thing"
              },
              "objectState": "undefined",
              "template": {
                "RALType": "thing",
                "version": "1",
                "objectStateTemplates": ["generalObjectState"]
              },
              "specificProperties": [
                {"key": "serial number", "value": "", "unit": "String"}
              ],
              "currentGeolocation": {
                "container": {"UID": "unknown"},
                "postalAddress": {"country": "unknown", "cityName": "unknown", "cityNumber": "unknown", "streetName": "unknown", "streetNumber": "unknown"},
                "3WordCode": "unknown",
                "geoCoordinates": {"longitude": 0, "latitude": 0},
                "plusCode": "unknown"
              },
              "locationHistoryRef": [],
              "ownerHistoryRef": [],
              "methodHistoryRef": [],
              "linkedObjectRef": []
            }
          };

          final ralMethod = RalMethod.fromMap(data);

          //definition
          expect(ralMethod.definition.definitionText, equals("myDefinitionText"), reason: "Definition should have the correct definitionText");

          //identity
          expect(ralMethod.identity.uid, equals("myUID"), reason: "Identity should have the correct uid");

          //methodState
          expect(ralMethod.methodState, equals("undefined"), reason: "MethodState should have the correct value");

          //template
          expect(ralMethod.template.ralType, equals("myMethodTemplate"), reason: "Template should have the correct ralType");
          expect(ralMethod.template.version, equals("1"), reason: "Template should have the correct version");
          expect(ralMethod.template.methodStateTemplates, equals(["generalMethodState"]), reason: "Template should have the correct methodStateTemplates");

          //specificProperties
          expect(ralMethod.specificProperties.containsKey("myKey"), isTrue, reason: "SpecificProperties should have myKey property");

          //inputObjects
          expect(ralMethod.inputObjects.length, equals(1), reason: "InputObjects should have the correct length");
          expect(ralMethod.inputObjects.first.identity.uid, equals("myNestedInputUid"), reason: "InputObject should have the correct uid");
          expect(ralMethod.inputObjects.first.role, equals("specialRoleForMethod"), reason: "InputObject should have the correct role");

          //inputObjectsRef
          expect(ralMethod.inputObjectsRef.length, equals(1), reason: "InputObjectsRef should have the correct length");
          expect(ralMethod.inputObjectsRef.first.uid, equals("inputRefUID"), reason: "InputObjectRef should have the correct uid");
          expect(ralMethod.inputObjectsRef.first.role, equals("myRole"), reason: "InputObjectRef should have the correct role");

          //outputObjects
          expect(ralMethod.outputObjects.length, equals(1), reason: "OutputObjects should have the correct length");
          expect(ralMethod.outputObjects.first.identity.uid, equals("myNestedOutputUid"), reason: "OutputObject should have the correct uid");

          //outputObjectsRef
          expect(ralMethod.outputObjectsRef.length, equals(1), reason: "OutputObjectsRef should have the correct length");
          expect(ralMethod.outputObjectsRef.first.uid, equals("outputRefUID"), reason: "OutputObjectRef should have the correct uid");
          expect(ralMethod.outputObjectsRef.first.role, equals("myRole"), reason: "OutputObjectRef should have the correct role");

          //nestedMethods
          expect(ralMethod.nestedMethods.length, equals(1), reason: "NestedMethods should have the correct length");
          expect(ralMethod.nestedMethods.first.identity.uid, equals("myNestedUid"), reason: "NestedMethod should have the correct uid");

          //executor
          expect(ralMethod.executor?.identity.uid, equals("myExecutorUid"), reason: "Executor should have the correct uid");
        });
      },
    );
  });
}
