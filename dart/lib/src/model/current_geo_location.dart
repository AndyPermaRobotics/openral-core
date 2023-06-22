import 'package:openral_core/src/model/container.dart';

class CurrentGeoLocation {
  final Container? container;

  //TODO: other fields
  ///"postalAddress": {
  ///       "country": "unknown",
  ///       "cityName": "unknown",
  ///       "cityNumber": "unknown",
  ///       "streetName": "unknown",
  ///       "streetNumber": "unknown"
  ///     },
  ///     "3WordCode": "unknown",
  ///     "geoCoordinates": {
  ///       "longitude": 0,
  ///       "latitude": 0
  ///     },
  ///     "plusCode": "unknown"

  const CurrentGeoLocation({this.container});

  Map<String, dynamic> toMap() {
    return {
      'container': container?.toMap(),
    };
  }
}
