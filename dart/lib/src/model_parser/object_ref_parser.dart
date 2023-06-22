import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field_string.dart';
import 'package:openral_core/src/cross/backend/parsing/parser_factory.dart';
import 'package:openral_core/src/model/object_ref.dart';

class ObjectRefParser extends ParserFactory<ObjectRef> {
  ParsableFieldString UID_FIELD = const ParsableFieldString("UID", isRequired: true);
  ParsableFieldString ROLE_FIELD = const ParsableFieldString("role", isRequired: false);

  @override
  ObjectRef create(Map<ParsableField, dynamic> parsedValues) {
    return ObjectRef(
      uid: parsedValues[UID_FIELD] as String,
      role: parsedValues[ROLE_FIELD] as String?,
    );
  }

  @override
  List<ParsableField> getFields(map) {
    return [
      UID_FIELD,
      ROLE_FIELD,
    ];
  }
}
