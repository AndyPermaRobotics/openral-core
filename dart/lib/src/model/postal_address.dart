class PostalAddress {
  String streetName;
  String streetNumber;
  String cityName;
  String cityNumber;
  String country;

  PostalAddress({
    required this.streetName,
    required this.streetNumber,
    required this.cityName,
    required this.cityNumber,
    required this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      'streetName': streetName,
      'streetNumber': streetNumber,
      'cityName': cityName,
      'cityNumber': cityNumber,
      'country': country,
    };
  }
}
