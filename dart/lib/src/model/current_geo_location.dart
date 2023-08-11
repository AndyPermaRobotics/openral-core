import 'package:openral_core/src/model/container.dart';
import 'package:openral_core/src/model/geo_coordinates.dart';
import 'package:openral_core/src/model/postal_address.dart';

class CurrentGeoLocation {
  Container? container;

  String? threeWordCode;

  PostalAddress? postalAddress;

  GeoCoordinates? geoCoordinates;

  String? plusCode;

  CurrentGeoLocation({
    this.container,
    this.postalAddress,
    this.threeWordCode,
    this.geoCoordinates,
    this.plusCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'container': container?.toMap(),
      'postalAddress': postalAddress?.toMap(),
      '3WordCode': threeWordCode,
      'geoCoordinates': geoCoordinates?.toMap(),
      'plusCode': plusCode,
    };
  }
}
