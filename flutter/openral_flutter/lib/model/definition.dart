import 'package:either_dart/either.dart';
import 'package:openral_flutter/cross/backend/parsing/parsing_error.dart';
import 'package:openral_flutter/model_parser/definition_parser.dart';

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

  static Either<Definition, ParsingError> fromMap(map) {
    final definitionParser = DefinitionParser();

    return definitionParser.fromMap(map);
  }
}
