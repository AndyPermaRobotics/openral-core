import 'package:openral_flutter/model/specific_properties.dart';
import 'package:openral_flutter/model/specific_property.dart';
import 'package:test/test.dart';

void main() {
  group(
    SpecificProperties,
    () {
      group('toMaps', () {
        test('returns list of maps with values', () async {
          //arrange
          final specificProperties = SpecificProperties({
            "key1": SpecificProperty(
              key: "key1",
              value: "value1",
              unit: "unit1",
            ),
            "key2": SpecificProperty(
              key: "key2",
              value: "value2",
              unit: "unit2",
            ),
          });

          //act
          final maps = specificProperties.toMaps();

          //assert
          expect(
            maps,
            equals([
              {
                "key": "key1",
                "value": "value1",
                "unit": "unit1",
              },
              {
                "key": "key2",
                "value": "value2",
                "unit": "unit2",
              },
            ]),
          );
        });
      });
    },
  );
}
