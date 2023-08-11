import 'package:either_dart/either.dart';
import 'package:openral_core/src/cross/backend/parsing/parsing_error.dart';
import 'package:openral_core/src/model_parser/method_template_parser.dart';

class MethodTemplate {
  String ralType;
  String version;
  List<String> methodStateTemplates;

  MethodTemplate({
    required this.ralType,
    required this.version,
    this.methodStateTemplates = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'RALType': ralType,
      'version': version,
      'methodStateTemplates': methodStateTemplates,
    };
  }

  static Either<MethodTemplate, ParsingError> fromMap(map) {
    final templateParser = MethodTemplateParser();

    return templateParser.fromMap(map);
  }
}
