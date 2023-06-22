import 'package:openral_core/src/model/container.dart';
import 'package:openral_core/src/model/current_geo_location.dart';
import 'package:test/test.dart';

void main() {
  group(
    CurrentGeoLocation,
    () {
      group('toMap', () {
        test('returns map with values', () async {
          //arrange
          final currentGeoLocation = CurrentGeoLocation(
            container: Container(
              uid: "uid1",
            ),
          );

          //act
          final map = currentGeoLocation.toMap();

          //assert
          expect(
            map,
            equals({
              "container": {
                "uid": "uid1",
              },
            }),
          );
        });
      });
    },
  );
}
