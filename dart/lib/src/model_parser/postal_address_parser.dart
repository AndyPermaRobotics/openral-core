import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field_string.dart';
import 'package:openral_core/src/cross/backend/parsing/parser_factory.dart';
import 'package:openral_core/src/model/postal_address.dart';

class PostalAddressParser extends ParserFactory<PostalAddress> {
  ParsableFieldString STREET_NAME_FIELD = const ParsableFieldString("streetName", isRequired: true);
  ParsableFieldString STREET_NUMBER_FIELD = const ParsableFieldString("streetNumber", isRequired: true);
  ParsableFieldString CITY_NAME_FIELD = const ParsableFieldString("cityName", isRequired: true);
  ParsableFieldString CITY_NUMBER_FIELD = const ParsableFieldString("cityNumber", isRequired: true);
  ParsableFieldString COUNTRY_FIELD = const ParsableFieldString("country", isRequired: true);

  @override
  PostalAddress create(Map<ParsableField, dynamic> parsedValues) {
    return PostalAddress(
      streetName: parsedValues[STREET_NAME_FIELD] as String,
      streetNumber: parsedValues[STREET_NUMBER_FIELD] as String,
      cityName: parsedValues[CITY_NAME_FIELD] as String,
      cityNumber: parsedValues[CITY_NUMBER_FIELD] as String,
      country: parsedValues[COUNTRY_FIELD] as String,
    );
  }

  @override
  List<ParsableField> getFields(map) {
    return [
      STREET_NAME_FIELD,
      STREET_NUMBER_FIELD,
      CITY_NAME_FIELD,
      CITY_NUMBER_FIELD,
      COUNTRY_FIELD,
    ];
  }
}
