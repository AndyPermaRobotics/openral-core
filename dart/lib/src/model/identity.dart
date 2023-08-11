import 'package:either_dart/either.dart';
import 'package:openral_core/src/cross/backend/parsing/parsing_error.dart';
import 'package:openral_core/src/model_parser/identity_parser.dart';

class Identity {
  String uid;
  String? name;
  String? siteTag;
  List<String> alternateIDs;
  List<String> alternateNames;

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

  static Either<Identity, ParsingError> fromMap(map) {
    final identityParser = IdentityParser();

    return identityParser.fromMap(map);
  }
}
