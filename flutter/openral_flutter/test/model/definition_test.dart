import 'package:openral_flutter/model/definition.dart';
import 'package:test/test.dart';

void main() {
  group(
    Definition,
    () {
      group('toMap', () {
        test('should return a map with the fields', () async {
          //arrage
          final definition = Definition(
            definitionText: "text",
            definitionURL: "url",
          );

          //act
          final map = definition.toMap();

          //assert
          expect(
            map,
            equals({
              "definitionText": "text",
              "definitionURL": "url",
            }),
          );
        });

        test('if values are null, return a map with null values', () async {
          //arrange
          final definition = Definition(
            definitionText: null,
            definitionURL: null,
          );

          //act
          final map = definition.toMap();

          //assert
          expect(
            map,
            equals({
              "definitionText": null,
              "definitionURL": null,
            }),
          );
        });
      });
    },
  );
}
