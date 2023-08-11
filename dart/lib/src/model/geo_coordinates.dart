class GeoCoordinates {
  double longitude;
  double latitude;

  GeoCoordinates({
    this.longitude = 0,
    this.latitude = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
