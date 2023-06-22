import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field_string.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_list_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parser_factory.dart';
import 'package:openral_core/src/model/identity.dart';

class IdentityParser extends ParserFactory<Identity> {
  ParsableFieldString UID_FIELD = const ParsableFieldString("UID", isRequired: true);
  ParsableFieldString NAME_FIELD = const ParsableFieldString("name", isRequired: false);
  ParsableFieldString SITE_TAG_FIELD = const ParsableFieldString("siteTag", isRequired: false);

  ParsableListField<String> ALTERNATE_IDS_FIELD = const ParsableListField<String>(
    "alternateIDs",
    isRequired: false,
    singleField: ParsableFieldString(""),
    defaultValue: [],
  );

  ParsableListField<String> ALTERNATE_NAMES_FIELD = const ParsableListField<String>(
    "alternateNames",
    isRequired: false,
    singleField: ParsableFieldString(""),
    defaultValue: [],
  );

  @override
  Identity create(Map<ParsableField, dynamic> parsedValues) {
    return Identity(
      uid: parsedValues[UID_FIELD] as String,
      name: parsedValues[NAME_FIELD] as String?,
      siteTag: parsedValues[SITE_TAG_FIELD] as String?,
      alternateIDs: parsedValues[ALTERNATE_IDS_FIELD] as List<String>,
      alternateNames: parsedValues[ALTERNATE_NAMES_FIELD] as List<String>,
    );
  }

  @override
  List<ParsableField> getFields(map) {
    return [
      UID_FIELD,
      NAME_FIELD,
      SITE_TAG_FIELD,
      ALTERNATE_IDS_FIELD,
      ALTERNATE_NAMES_FIELD,
    ];
  }
}
