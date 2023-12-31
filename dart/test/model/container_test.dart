import 'package:openral_core/src/model/container.dart';
import 'package:test/test.dart';

void main() {
  group(
    Container,
    () {
      group('toMap', () {
        test('returns map', () async {
          //arrange
          final container = Container(
            uid: "uid1",
          );

          //act
          final map = container.toMap();

          //assert
          expect(
            map,
            equals({
              "UID": "uid1",
            }),
          );
        });
      });
    },
  );
}
