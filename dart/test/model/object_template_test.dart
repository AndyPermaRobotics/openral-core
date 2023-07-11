import 'package:openral_core/src/model/object_template.dart';
import 'package:test/test.dart';

void main() {
  group(
    ObjectTemplate,
    () {
      group('toMap', () {
        test('returns map with values', () async {
          //arrange
          final template = ObjectTemplate(
            ralType: "ralType",
            version: "version",
            objectStateTemplates: ["objectStateTemplates"],
          );

          //act
          final map = template.toMap();

          //assert
          expect(
            map,
            equals({
              "RALType": "ralType",
              "version": "version",
              "objectStateTemplates": ["objectStateTemplates"],
            }),
          );
        });
      });
    },
  );
}
