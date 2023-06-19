import 'package:either_dart/either.dart';
import 'package:openral_flutter/cross/backend/parsing/parseable_field.dart';
import 'package:openral_flutter/cross/backend/parsing/parsing_error.dart';

class MapParser {
  ///tries to parse each value in [map] that has the same key as one of the [fields].
  ///Additonal key value pairs in [map] are ignored
  static Either<Map<ParsableField, dynamic>, ParsingError> parse(
    dynamic map,
    List<ParsableField> fields,
  ) {
    if (map == null) {
      return Right(ParsingError("Could not parse because map is null"));
    } else if (map is Map == false) {
      return Right(ParsingError("Could not parse expected map, but got $map ${map.runtimeType}"));
    }
    final parsedValues = <ParsableField, dynamic>{};

    var parsingErrors = <ParsingError>[];

    for (var field in fields) {
      var result = field.parse(map[field.key]);

      if (result.isRight) {
        parsingErrors.add(result.right);
      } else {
        parsedValues[field] = result.left;
      }
    }

    if (parsingErrors.isNotEmpty) {
      //TODO: This can become a method of ParsingError isSelf?
      var composedMessage = parsingErrors.fold<String?>(null, (fold, parsingError) {
        if (fold == null) {
          return "- ${parsingError.message}";
        } else {
          return "$fold\n- ${parsingError.message}";
        }
      });

      return Right(ParsingError("${parsingErrors.length} ParsingErrors: \n$composedMessage \n\nvalue was: $map"));
    } else {
      return Left(parsedValues);
    }
  }
}
