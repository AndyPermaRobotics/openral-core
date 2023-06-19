import 'package:flutter_test/flutter_test.dart';
import 'package:openral_flutter/model/definition.dart';
import 'package:openral_flutter/model/identity.dart';
import 'package:openral_flutter/model/ral_object.dart';
import 'package:openral_flutter/model/specific_properties.dart';
import 'package:openral_flutter/model/specific_property.dart';
import 'package:openral_flutter/model/template.dart';

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
        template: Template(
          ralType: "",
          version: "",
          objectStateTemplates: "",
        ),
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
        template: Template(
          ralType: "",
          version: "",
          objectStateTemplates: "",
        ),
      );

      expect(
        myRalObject.specificProperties["myProperty"],
        "myValue",
        reason: "Expect 'myValue' for ['myProperty']",
      );
    });
  });
}
