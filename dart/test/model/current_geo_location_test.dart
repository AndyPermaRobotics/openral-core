import 'package:openral_core/src/model/container.dart';
import 'package:openral_core/src/model/current_geo_location.dart';
import 'package:openral_core/src/model/geo_coordinates.dart';
import 'package:openral_core/src/model/postal_address.dart';
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
            postalAddress: PostalAddress(
              cityName: "Hannover",
              cityNumber: "30657",
              streetName: "Example Street",
              streetNumber: "123a",
              country: "Germany",
            ),
            plusCode: "plusCode",
            threeWordCode: "threeWordCode",
            geoCoordinates: GeoCoordinates(
              longitude: 12.0,
              latitude: 21.0,
            ),
          );

          //act
          final map = currentGeoLocation.toMap();

          //assert
          expect(
            map,
            equals({
              "container": {
                "UID": "uid1",
              },
              "postalAddress": {
                "streetName": "Example Street",
                "streetNumber": "123a",
                "cityName": "Hannover",
                "cityNumber": "30657",
                "country": "Germany",
              },
              "3WordCode": "threeWordCode",
              "geoCoordinates": {
                "longitude": 12.0,
                "latitude": 21.0,
              },
              "plusCode": "plusCode",
            }),
          );
        });
      });
    },
  );
}
