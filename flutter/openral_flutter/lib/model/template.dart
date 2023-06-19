import 'package:either_dart/either.dart';
import 'package:openral_flutter/cross/backend/parsing/parsing_error.dart';
import 'package:openral_flutter/model_parser/template_parser.dart';

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

  static Either<Template, ParsingError> fromMap(map) {
    final templateParser = TemplateParser();

    return templateParser.fromMap(map);
  }
}
