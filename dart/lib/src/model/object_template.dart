import 'package:either_dart/either.dart';
import 'package:openral_core/src/cross/backend/parsing/parsing_error.dart';
import 'package:openral_core/src/model_parser/object_template_parser.dart';

class ObjectTemplate {
  final String ralType;
  final String version;
  final List<String> objectStateTemplates;

  ObjectTemplate({
    required this.ralType,
    required this.version,
    this.objectStateTemplates = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'RALType': ralType,
      'version': version,
      'objectStateTemplates': objectStateTemplates,
    };
  }

  static Either<ObjectTemplate, ParsingError> fromMap(map) {
    final templateParser = ObjectTemplateParser();

    return templateParser.fromMap(map);
  }
}
