import 'package:openral_core/src/model/method_template.dart';
import 'package:test/test.dart';

void main() {
  group(
    MethodTemplate,
    () {
      group('toMap', () {
        test('returns map with values', () async {
          //arrange
          final template = MethodTemplate(
            ralType: "ralType",
            version: "version",
            methodStateTemplates: ["methodStateTemplates"],
          );

          //act
          final map = template.toMap();

          //assert
          expect(
            map,
            equals({
              "RALType": "ralType",
              "version": "version",
              "methodStateTemplates": ["methodStateTemplates"],
            }),
          );
        });
      });
    },
  );
}
