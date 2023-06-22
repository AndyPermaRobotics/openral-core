import 'package:either_dart/either.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field_custom_simple.dart';
import 'package:openral_core/src/cross/backend/parsing/parsing_error.dart';
import 'package:openral_core/src/model/specific_properties.dart';
import 'package:openral_core/src/model/specific_property.dart';
import 'package:openral_core/src/model_parser/specific_property_parser.dart';

class SpecificPropertiesParser extends ParsableFieldCustomSimple<SpecificProperties> {
  SpecificPropertiesParser()
      : super(
          "specificProperties",
          defaultValue: SpecificProperties({}),
          parserFunc: (raw) {
            final specificPropertyParser = SpecificPropertyParser();

            if (raw is List == false) {
              return Right(ParsingError("specificProperties must be a list"));
            }

            final Map<String, SpecificProperty> map = {};

            for (final element in raw) {
              final result = specificPropertyParser.fromMap(element);

              if (result.isRight) {
                return Right(ParsingError("Could not parse specificProperties, because the element $element could not be parsed: ${result.right}"));
              } else {
                final specificProperty = result.left;

                map[specificProperty.key] = specificProperty;
              }
            }
            return Left(SpecificProperties(map));
          },
        );
}
