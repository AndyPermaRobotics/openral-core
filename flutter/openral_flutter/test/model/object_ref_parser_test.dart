import 'package:openral_flutter/model_parser/object_ref_parser.dart';
import 'package:test/test.dart';

void main() {
  group(ObjectRefParser, () {
    group('fromMap', () {
      test('should return a ObjectRef with the correct values', () {
        //Arrange
        final data = {
          "UID": "1234",
          "role": "ownerRole",
        };

        //Act
        final result = ObjectRefParser().fromMap(data);

        //Assert
        expect(result.isLeft, isTrue, reason: result.isRight ? result.right.toString() : null);

        final objectRef = result.left;
        expect(objectRef.uid, equals("1234"));
        expect(objectRef.role, equals("ownerRole"));
      });
    });
  });
}
