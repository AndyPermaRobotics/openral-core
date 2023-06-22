import 'package:openral_core/src/model/template.dart';
import 'package:test/test.dart';

void main() {
  group(
    Template,
    () {
      group('toMap', () {
        test('returns map with values', () async {
          //arrange
          final template = Template(
            ralType: "ralType",
            version: "version",
            objectStateTemplates: "objectStateTemplates",
          );

          //act
          final map = template.toMap();

          //assert
          expect(
            map,
            equals({
              "ralType": "ralType",
              "version": "version",
              "objectStateTemplates": "objectStateTemplates",
            }),
          );
        });
      });
    },
  );
}
