class SpecificProperty {
  final String key;
  final String value;
  final String? unit;

  SpecificProperty({
    required this.key,
    required this.value,
    this.unit,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'value': value,
      'unit': unit,
    };
  }
}
