import 'package:openral_flutter/model_parser/specific_properties_parser.dart';
import 'package:test/test.dart';

void main() {
  group(
    SpecificPropertiesParser,
    () {
      test(
        'parsed a list of specific properties to a SpecificProperties object',
        () async {
          final parser = SpecificPropertiesParser();

          final result = parser.parse([
            {"key": "key1", "value": "value1", "unit": "String"},
            {"key": "key2", "value": "value2", "unit": "int"}
          ]);

          expect(result.isLeft, isTrue, reason: result.isRight ? result.right.toString() : null);

          final specificProperties = result.left;

          expect(specificProperties, isNotNull);

          expect(specificProperties.containsKey("key1"), isTrue, reason: "key1 should exist");
          expect(specificProperties.get("key1")!.value, "value1");
          expect(specificProperties.get("key1")!.unit, "String");

          expect(specificProperties.containsKey("key2"), isTrue, reason: "key2 should exist");
          expect(specificProperties.get("key2")!.value, "value2");
          expect(specificProperties.get("key2")!.unit, "int");
        },
      );

      test('returns a ParsingError, if one of the elements of the list can not be parsed', () async {
        final parser = SpecificPropertiesParser();

        final result = parser.parse([
          {"key": "key1", "value": "value1", "unit": "String"},
          {"key": "key2", "unit": "int"} //value is missing here
        ]);

        expect(result.isRight, isTrue, reason: "Expected to get Either.right, but got Left(${result.isLeft ? result.left : null})");

        print(result.right);
      });
    },
  );
}
