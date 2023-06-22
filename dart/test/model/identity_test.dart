import 'package:openral_core/src/model/identity.dart';
import 'package:test/test.dart';

void main() {
  group(
    Identity,
    () {
      group('toMap', () {
        test('returns a map with values', () async {
          //arrange
          final identity = Identity(
            uid: "uid",
            name: "name",
            siteTag: "siteTag",
            alternateIDs: ["alternateIDs"],
            alternateNames: ["alternateNames"],
          );

          //act
          final map = identity.toMap();

          //assert
          expect(
            map,
            equals({
              "UID": "uid",
              "name": "name",
              "siteTag": "siteTag",
              "alternateIDs": ["alternateIDs"],
              "alternateNames": ["alternateNames"]
            }),
          );
        });

        test('if values are null, return a map with null values', () async {
          //arrange
          final identity = Identity(
            uid: "uid",
            name: null,
            siteTag: null,
            alternateIDs: [],
            alternateNames: [],
          );

          //act
          final map = identity.toMap();

          //assert

          expect(
            map,
            equals({
              "UID": "uid",
              "name": null,
              "siteTag": null,
              "alternateIDs": [],
              "alternateNames": [],
            }),
          );
        });
      });
    },
  );
}
