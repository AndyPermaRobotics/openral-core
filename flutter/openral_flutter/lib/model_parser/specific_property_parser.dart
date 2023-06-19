import 'package:openral_flutter/cross/backend/parsing/parseable_field.dart';
import 'package:openral_flutter/cross/backend/parsing/parseable_field_string.dart';
import 'package:openral_flutter/cross/backend/parsing/parser_factory.dart';
import 'package:openral_flutter/model/specific_property.dart';

class SpecificPropertyParser extends ParserFactory<SpecificProperty> {
  ParsableFieldString KEY_FIELD = const ParsableFieldString(
    "key",
    isRequired: true,
  );

  ParsableFieldString VALUE_FIELD = const ParsableFieldString(
    "value",
    isRequired: true,
  );

  ParsableFieldString UNIT_FIELD = const ParsableFieldString(
    "unit",
    isRequired: false,
  );

  @override
  SpecificProperty create(Map<ParsableField, dynamic> parsedValues) {
    return SpecificProperty(
      key: parsedValues[KEY_FIELD] as String,
      value: parsedValues[VALUE_FIELD] as String,
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
