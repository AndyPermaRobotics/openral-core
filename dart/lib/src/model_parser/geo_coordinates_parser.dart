import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field_double.dart';
import 'package:openral_core/src/cross/backend/parsing/parser_factory.dart';
import 'package:openral_core/src/model/geo_coordinates.dart';

class GeoCoordinatesParser extends ParserFactory<GeoCoordinates> {
  ParsableFieldDouble LONGITUDE_FIELD = const ParsableFieldDouble("longitude", isRequired: true);
  ParsableFieldDouble LATITUDE_FIELD = const ParsableFieldDouble("latitude", isRequired: true);

  @override
  GeoCoordinates create(Map<ParsableField, dynamic> parsedValues) {
    return GeoCoordinates(
      longitude: parsedValues[LONGITUDE_FIELD] as double,
      latitude: parsedValues[LATITUDE_FIELD] as double,
    );
  }

  @override
  List<ParsableField> getFields(map) {
    return [
      LONGITUDE_FIELD,
      LATITUDE_FIELD,
    ];
  }
}
