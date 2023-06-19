class Template {
  final String ralType;
  final String version;
  final String? objectStateTemplates;

  Template({
    required this.ralType,
    required this.version,
    this.objectStateTemplates,
  });

  Map<String, dynamic> toMap() {
    return {
      'RALType': ralType,
      'version': version,
      'objectStateTemplates': objectStateTemplates,
    };
  }
}
