import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field_dynamic.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field_string.dart';
import 'package:openral_core/src/cross/backend/parsing/parser_factory.dart';
import 'package:openral_core/src/model/specific_property.dart';

class SpecificPropertyParser extends ParserFactory<SpecificProperty> {
  ParsableFieldString KEY_FIELD = const ParsableFieldString(
    "key",
    isRequired: true,
  );

  ParsableFieldDynamic VALUE_FIELD = const ParsableFieldDynamic(
    "value",
    isRequired: false,
  );

  ParsableFieldString UNIT_FIELD = const ParsableFieldString(
    "unit",
    isRequired: false,
  );

  @override
  SpecificProperty create(Map<ParsableField, dynamic> parsedValues) {
    return SpecificProperty(
      key: parsedValues[KEY_FIELD] as String,
      value: parsedValues[VALUE_FIELD],
      unit: parsedValues[UNIT_FIELD] as String?,
    );
  }

  @override
  List<ParsableField> getFields(map) {
    return [
      KEY_FIELD,
      VALUE_FIELD,
      UNIT_FIELD,
    ];
  }
}
