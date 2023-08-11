import 'package:openral_core/src/model/current_geo_location.dart';
import 'package:openral_core/src/model/definition.dart';
import 'package:openral_core/src/model/identity.dart';
import 'package:openral_core/src/model/object_template.dart';
import 'package:openral_core/src/model/ral_object.dart';
import 'package:openral_core/src/model/specific_properties.dart';
import 'package:openral_core/src/model/specific_property.dart';
import 'package:test/test.dart';

class MySpecificProperties extends SpecificProperties {
  MySpecificProperties(super.specificProperties);

  String get myPropertyValue => this["myProperty"];
}

void main() {
  group(RalObject, () {
    test('MySpecificProperties can be used to access specific properties', () async {
      final myRalObject = RalObject<MySpecificProperties>(
        definition: Definition(definitionText: ""),
        identity: Identity(
          uid: "",
          name: "",
          alternateIDs: [],
          alternateNames: [],
          siteTag: "",
        ),
        specificProperties: MySpecificProperties(
          {
            "myProperty": SpecificProperty(
              key: "myProperty",
              value: "myValue",
              unit: "String",
            ),
          },
        ),
        template: ObjectTemplate(
          ralType: "",
          version: "",
          objectStateTemplates: [""],
        ),
        currentGeoLocation: CurrentGeoLocation(),
      );

      expect(
        myRalObject.specificProperties.myPropertyValue,
        "myValue",
      );
    });

    test('no type generic', () async {
      final myRalObject = RalObject(
        definition: Definition(definitionText: ""),
        identity: Identity(
          uid: "",
          name: "",
          alternateIDs: [],
          alternateNames: [],
          siteTag: "",
        ),
        specificProperties: MySpecificProperties(
          {
            "myProperty": SpecificProperty(
              key: "myProperty",
              value: "myValue",
              unit: "String",
            ),
          },
        ),
        template: ObjectTemplate(
          ralType: "",
          version: "",
          objectStateTemplates: [""],
        ),
        currentGeoLocation: CurrentGeoLocation(),
      );

      expect(
        myRalObject.specificProperties["myProperty"],
        "myValue",
        reason: "Expect 'myValue' for ['myProperty']",
      );
    });
  });
}
