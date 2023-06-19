class Identity {
  final String uid;
  final String? name;
  final String? siteTag;
  final List<String> alternateIDs;
  final List<String> alternateNames;

  Identity({
    required this.uid,
    this.name,
    this.siteTag,
    this.alternateIDs = const [],
    this.alternateNames = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      "UID": uid,
      "name": name,
      "siteTag": siteTag,
      "alternateIDs": alternateIDs,
      "alternateNames": alternateNames,
    };
  }
}
