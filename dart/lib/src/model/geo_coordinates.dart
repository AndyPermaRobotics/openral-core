class GeoCoordinates {
  final double longitude;
  final double latitude;

  const GeoCoordinates({
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
