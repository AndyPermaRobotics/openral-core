import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field_string.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_list_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parser_factory.dart';
import 'package:openral_core/src/model/method_template.dart';

class MethodTemplateParser extends ParserFactory<MethodTemplate> {
  ParsableFieldString RAL_TYPE_FIELD = const ParsableFieldString(
    "RALType",
    isRequired: true,
  );
  ParsableFieldString VERSION_FIELD = const ParsableFieldString(
    "version",
    isRequired: true,
  );

  ParsableListField<String> METHOD_STATE_TEMPLATES_FIELD = ParsableListField<String>(
    "methodStateTemplates",
    isRequired: false,
    singleField: ParsableFieldString(""),
  );

  @override
  MethodTemplate create(Map<ParsableField, dynamic> parsedValues) {
    return MethodTemplate(
      ralType: parsedValues[RAL_TYPE_FIELD] as String,
      version: parsedValues[VERSION_FIELD] as String,
      methodStateTemplates: parsedValues[METHOD_STATE_TEMPLATES_FIELD] as List<String>? ?? [],
    );
  }

  @override
  List<ParsableField> getFields(map) {
    return [
      RAL_TYPE_FIELD,
      VERSION_FIELD,
      METHOD_STATE_TEMPLATES_FIELD,
    ];
  }
}
