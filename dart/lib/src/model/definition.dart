import 'package:either_dart/either.dart';
import 'package:openral_core/src/cross/backend/parsing/parsing_error.dart';
import 'package:openral_core/src/model_parser/definition_parser.dart';

class Definition {
  String? definitionText;
  String? definitionURL;

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

  static Either<Definition, ParsingError> fromMap(map) {
    final definitionParser = DefinitionParser();

    return definitionParser.fromMap(map);
  }
}
