import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field_string.dart';
import 'package:openral_core/src/cross/backend/parsing/parser_factory.dart';
import 'package:openral_core/src/model/definition.dart';

class DefinitionParser extends ParserFactory<Definition> {
  ParsableFieldString DEFINITION_TEXT_FIELD = const ParsableFieldString(
    "definitionText",
    isRequired: false,
  );

  ParsableFieldString DEFINITION_URL_FIELD = const ParsableFieldString(
    "definitionURL",
    isRequired: false,
  );

  @override
  Definition create(Map<ParsableField, dynamic> parsedValues) {
    return Definition(
      definitionText: parsedValues[DEFINITION_TEXT_FIELD] as String?,
      definitionURL: parsedValues[DEFINITION_URL_FIELD] as String?,
    );
  }

  @override
  List<ParsableField> getFields(map) {
    return [
      DEFINITION_TEXT_FIELD,
      DEFINITION_URL_FIELD,
    ];
  }
}
