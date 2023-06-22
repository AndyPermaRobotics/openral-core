import 'package:either_dart/either.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parsing_error.dart';

/// A [ParsableField] that parses a [Map] of [K] to [V].
/// if [keyField] or [valueField] fail to parse, the entire [Map] will fail to parse and a [ParsingError] will be returned.
class ParsableMapField<K, V> extends ParsableField<Map<K, V>?> {
  final ParsableField keyField;
  final ParsableField valueField;

  const ParsableMapField(
    String key, {
    required this.keyField,
    required this.valueField,
    super.isRequired = true,
    super.defaultValue,
  }) : super(key);

  @override
  Either<Map<K, V>, ParsingError> parseInner(dynamic value) {
    if (value is Map == false) {
      return Right(ParsingError("ParsableMapField: Expected a Map for '${key}', but got '$value'"));
    }

    var elementMap = <K, V>{};
    var parsingErrors = <ParsingError>[];

    var map = value as Map;
    for (var entry in map.entries) {
      var keyResult = keyField.parse(entry.key);
      var valueResult = valueField.parse(entry.value);

      if (keyResult.isLeft && valueResult.isLeft) {
        elementMap[keyResult.left] = valueResult.left;
      } else {
        if (keyResult.isRight) {
          parsingErrors.add(ParsingError("Could not parse key: ${keyResult.right.message} for map entry: $entry"));
        }
        if (valueResult.isRight) {
          parsingErrors.add(ParsingError("Could not parse value: ${valueResult.right.message} for map entry: $entry"));
        }
      }
    }

    if (parsingErrors.isEmpty) {
      return Left(elementMap);
    } else {
      var composedMessage = parsingErrors.fold<String?>(null, (fold, parsingError) {
        if (fold == null) {
          return "- ${parsingError.message}";
        } else {
          return "$fold\n- ${parsingError.message}";
        }
      });

      return Right(ParsingError("${parsingErrors.length} ParsingErrors of Map '$key': \n$composedMessage \n\nvalue was: $value"));
    }
  }
}
