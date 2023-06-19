import 'package:openral_flutter/cross/backend/parsing/parseable_field.dart';
import 'package:openral_flutter/cross/backend/parsing/parseable_field_custom_simple.dart';
import 'package:openral_flutter/cross/backend/parsing/parseable_field_nested.dart';
import 'package:openral_flutter/cross/backend/parsing/parseable_field_string.dart';
import 'package:openral_flutter/cross/backend/parsing/parseable_list_field.dart';
import 'package:openral_flutter/cross/backend/parsing/parser_factory.dart';
import 'package:openral_flutter/model/current_geo_location.dart';
import 'package:openral_flutter/model/definition.dart';
import 'package:openral_flutter/model/identity.dart';
import 'package:openral_flutter/model/ral_object.dart';
import 'package:openral_flutter/model/specific_properties.dart';
import 'package:openral_flutter/model/template.dart';
import 'package:openral_flutter/model_parser/definition_parser.dart';
import 'package:openral_flutter/model_parser/geo_location_parser.dart';
import 'package:openral_flutter/model_parser/identity_parser.dart';
import 'package:openral_flutter/model_parser/specific_properties_parser.dart';
import 'package:openral_flutter/model_parser/template_parser.dart';

class RalObjectParser<S extends SpecificProperties> extends ParserFactory<RalObject<S>> {
  ParsableFieldNested<Identity> IDENTITY_FIELD = ParsableFieldNested(
    "identity",
    isRequired: true,
    parserFactory: IdentityParser(),
  );

  ParsableListField<String> CURRENT_OWNERS_FIELD = ParsableListField<String>(
    "currentOwners",
    isRequired: false,
    defaultValue: [],
    singleField: ParsableFieldString(""),
  );

  ParsableFieldNested<Definition> DEFINITION_FIELD = ParsableFieldNested(
    "definition",
    isRequired: false,
    defaultValue: null,
    parserFactory: DefinitionParser(),
  );

  ParsableFieldString OBJECT_STATE_FIELD = ParsableFieldString(
    "objectState",
    isRequired: false,
    defaultValue: "undefined",
  );

  ParsableFieldNested<Template> TEMPLATE_FIELD = ParsableFieldNested(
    "template",
    isRequired: true,
    parserFactory: TemplateParser(),
  );

  ParsableFieldCustomSimple<SpecificProperties> SPECIFIC_PROPERTIES_FIELD = SpecificPropertiesParser();

  ParsableFieldNested<CurrentGeoLocation> CURRENT_GEOLOCATION_FIELD = ParsableFieldNested(
    "currentGeolocation",
    isRequired: false,
    defaultValue: null,
    parserFactory: GeoLocationParser(),
  );

  ParsableListField<String> LOCATION_HISTORY_REF_FIELD = ParsableListField<String>(
    "locationHistoryRef",
    isRequired: false,
    defaultValue: [],
    singleField: ParsableFieldString(""),
  );

  ParsableListField<String> OWNER_HISTORY_REF_FIELD = ParsableListField<String>(
    "ownerHistoryRef",
    isRequired: false,
    defaultValue: [],
    singleField: ParsableFieldString(""),
  );

  ParsableListField<String> METHOD_HISTORY_REF_FIELD = ParsableListField<String>(
    "methodHistoryRef",
    isRequired: false,
    defaultValue: [],
    singleField: ParsableFieldString(""),
  );

  ParsableListField<String> LINKED_OBJECT_REF_FIELD = ParsableListField<String>(
    "linkedObjectRef",
    isRequired: false,
    defaultValue: [],
    singleField: ParsableFieldString(""),
  );

  @override
  RalObject<S> create(Map<ParsableField, dynamic> parsedValues) {
    return RalObject<S>(
      identity: parsedValues[IDENTITY_FIELD]!,
      currentOwners: parsedValues[CURRENT_OWNERS_FIELD]!,
      definition: parsedValues[DEFINITION_FIELD],
      objectState: parsedValues[OBJECT_STATE_FIELD]!,
      template: parsedValues[TEMPLATE_FIELD]!,
      specificProperties: parsedValues[SPECIFIC_PROPERTIES_FIELD],
      currentGeolocation: parsedValues[CURRENT_GEOLOCATION_FIELD],
      locationHistoryRef: parsedValues[LOCATION_HISTORY_REF_FIELD]!,
      ownerHistoryRef: parsedValues[OWNER_HISTORY_REF_FIELD]!,
      methodHistoryRef: parsedValues[METHOD_HISTORY_REF_FIELD]!,
      linkedObjectRef: parsedValues[LINKED_OBJECT_REF_FIELD]!,
    );
  }

  @override
  List<ParsableField> getFields(map) {
    return [
      IDENTITY_FIELD,
      CURRENT_OWNERS_FIELD,
      DEFINITION_FIELD,
      OBJECT_STATE_FIELD,
      TEMPLATE_FIELD,
      SPECIFIC_PROPERTIES_FIELD,
      CURRENT_GEOLOCATION_FIELD,
      LOCATION_HISTORY_REF_FIELD,
      OWNER_HISTORY_REF_FIELD,
      METHOD_HISTORY_REF_FIELD,
      LINKED_OBJECT_REF_FIELD,
    ];
  }
}
