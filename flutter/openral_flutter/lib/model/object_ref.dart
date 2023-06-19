class ObjectRef {
  final String uid;
  final String? role;

  ObjectRef({
    required this.uid,
    this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'UID': uid,
      'role': role,
    };
  }

  static ObjectRef fromMap(Map<String, dynamic> map) {
    dynamic uid = map['UID'];

    if (uid == null) {
      throw ArgumentError('UID is required');
    } else if (uid is! String) {
      throw ArgumentError('UID must be a string');
    }

    return ObjectRef(uid: uid, role: map['role']);
  }
}
