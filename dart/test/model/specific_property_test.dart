import 'package:openral_core/src/model/specific_property.dart';
import 'package:test/test.dart';

void main() {
  group(
    SpecificProperty,
    () {
      group('toMap', () {
        test('returns map with values', () async {
          //arrange
          final specificProperty = SpecificProperty(
            key: "key",
            value: "value",
            unit: "unit",
          );

          //act
          final map = specificProperty.toMap();

          //assert
          expect(
            map,
            equals({
              "key": "key",
              "value": "value",
              "unit": "unit",
            }),
          );
        });
      });
    },
  );
}
