import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field_nested.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field_string.dart';
import 'package:openral_core/src/cross/backend/parsing/parser_factory.dart';
import 'package:openral_core/src/model/container.dart';
import 'package:openral_core/src/model/current_geo_location.dart';
import 'package:openral_core/src/model/geo_coordinates.dart';
import 'package:openral_core/src/model/postal_address.dart';
import 'package:openral_core/src/model_parser/container_parser.dart';
import 'package:openral_core/src/model_parser/geo_coordinates_parser.dart';
import 'package:openral_core/src/model_parser/postal_address_parser.dart';

///Represents the RalObject Field currentGeolocation
/// "currentGeolocation": {
///     "container": {
///       "UID": "unknown"
///     },
///     "postalAddress": {
///       "country": "unknown",
///       "cityName": "unknown",
///       "cityNumber": "unknown",
///       "streetName": "unknown",
///       "streetNumber": "unknown"
///     },
///     "3WordCode": "unknown",
///     "geoCoordinates": {
///       "longitude": 0,
///       "latitude": 0
///     },
///     "plusCode": "unknown"
///   },
class GeoLocationParser extends ParserFactory<CurrentGeoLocation> {
  final ParsableFieldNested<Container> CONTAINER_FIELD = ParsableFieldNested<Container>(
    "container",
    isRequired: false,
    parserFactory: ContainerParser(),
  );

  final ParsableFieldNested<PostalAddress> POSTAL_ADDRESS_FIELD = ParsableFieldNested<PostalAddress>(
    "postalAddress",
    isRequired: false,
    parserFactory: PostalAddressParser(),
  );

  final ParsableFieldNested<GeoCoordinates> GEO_COORDINATES_FIELD = ParsableFieldNested<GeoCoordinates>(
    "geoCoordinates",
    isRequired: false,
    parserFactory: GeoCoordinatesParser(),
  );

  ParsableFieldString THREE_WORD_CODE_FIELD = const ParsableFieldString(
    "3WordCode",
    isRequired: false,
  );

  ParsableFieldString PLUS_CODE_FIELD = const ParsableFieldString(
    "plusCode",
    isRequired: false,
  );

  @override
  CurrentGeoLocation create(Map<ParsableField, dynamic> parsedValues) {
    return CurrentGeoLocation(
      container: parsedValues[CONTAINER_FIELD] as Container?,
      plusCode: parsedValues[PLUS_CODE_FIELD] as String?,
      threeWordCode: parsedValues[THREE_WORD_CODE_FIELD] as String?,
      postalAddress: parsedValues[POSTAL_ADDRESS_FIELD] as PostalAddress?,
      geoCoordinates: parsedValues[GEO_COORDINATES_FIELD] as GeoCoordinates?,
    );
  }

  @override
  List<ParsableField> getFields(map) {
    return [
      CONTAINER_FIELD,
      PLUS_CODE_FIELD,
      THREE_WORD_CODE_FIELD,
      POSTAL_ADDRESS_FIELD,
      GEO_COORDINATES_FIELD,
    ];
  }
}
