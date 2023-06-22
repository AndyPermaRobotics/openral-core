import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field_string.dart';
import 'package:openral_core/src/model/container.dart';

import '../cross/backend/parsing/parser_factory.dart';

class ContainerParser extends ParserFactory<Container> {
  ParsableFieldString UID_FIELD = const ParsableFieldString("UID", isRequired: true);

  @override
  Container create(Map<ParsableField, dynamic> parsedValues) {
    return Container(
      uid: parsedValues[UID_FIELD] as String,
    );
  }

  @override
  List<ParsableField> getFields(map) {
    return [UID_FIELD];
  }
}
