class Container {
  final String uid;

  Container({required this.uid});

  Map<String, dynamic> toMap() {
    return {
      'UID': uid,
    };
  }
}
