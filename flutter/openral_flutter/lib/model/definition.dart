class Definition {
  final String? definitionText;
  final String? definitionURL;

  Definition({
    this.definitionText,
    this.definitionURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'definitionText': definitionText,
      'definitionURL': definitionURL,
    };
  }
}
