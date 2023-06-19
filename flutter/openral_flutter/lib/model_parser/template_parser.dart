import 'package:openral_flutter/cross/backend/parsing/parseable_field.dart';
import 'package:openral_flutter/cross/backend/parsing/parseable_field_string.dart';
import 'package:openral_flutter/cross/backend/parsing/parser_factory.dart';
import 'package:openral_flutter/model/template.dart';

class TemplateParser extends ParserFactory<Template> {
  ParsableFieldString RAL_TYPE_FIELD = const ParsableFieldString(
    "RALType",
    isRequired: true,
  );
  ParsableFieldString VERSION_FIELD = const ParsableFieldString(
    "version",
    isRequired: true,
  );
  ParsableFieldString OBJECT_STATE_TEMPLATES_FIELD = const ParsableFieldString(
    "objectStateTemplates",
    isRequired: false,
  );

  @override
  Template create(Map<ParsableField, dynamic> parsedValues) {
    return Template(
      ralType: parsedValues[RAL_TYPE_FIELD] as String,
      version: parsedValues[VERSION_FIELD] as String,
      objectStateTemplates: parsedValues[OBJECT_STATE_TEMPLATES_FIELD] as String?,
    );
  }

  @override
  List<ParsableField> getFields(map) {
    return [
      RAL_TYPE_FIELD,
      VERSION_FIELD,
      OBJECT_STATE_TEMPLATES_FIELD,
    ];
  }
}
