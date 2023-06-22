import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field_nested.dart';
import 'package:openral_core/src/cross/backend/parsing/parser_factory.dart';
import 'package:openral_core/src/model/container.dart';
import 'package:openral_core/src/model/current_geo_location.dart';
import 'package:openral_core/src/model_parser/container_parser.dart';

class GeoLocationParser extends ParserFactory<CurrentGeoLocation> {
  final ParsableFieldNested<Container> CONTAINER_FIELD = ParsableFieldNested<Container>(
    "container",
    isRequired: false,
    parserFactory: ContainerParser(),
  );

  @override
  CurrentGeoLocation create(Map<ParsableField, dynamic> parsedValues) {
    return CurrentGeoLocation(
      container: parsedValues[CONTAINER_FIELD] as Container?,
    );
  }

  @override
  List<ParsableField> getFields(map) {
    return [
      CONTAINER_FIELD,
    ];
  }
}
