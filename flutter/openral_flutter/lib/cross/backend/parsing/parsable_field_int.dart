import 'package:collection/collection.dart';
import 'package:either_dart/either.dart';
import 'package:openral_flutter/cross/backend/parsing/parseable_field.dart';
import 'package:openral_flutter/cross/backend/parsing/parsing_error.dart';

class ParsableFieldInt extends ParsableField<int> {
  ///is useful for parsing e.g. "320px" to 320
  final List<String> allowedSuffixes;

  //returns the element from [suffixes] that [value] ends with, or null, if value does not end with any of them
  static String? endsWithSuffix(String? value, List<String>? suffixes) {
    if (value == null || suffixes == null) return null;
    return suffixes.firstWhereOrNull((suffix) => value.endsWith(suffix));
  }

  const ParsableFieldInt(
    String key, {
    this.allowedSuffixes = const <String>[],
    super.isRequired = true,
    super.defaultValue,
  }) : super(key);

  @override
  Either<int, ParsingError> parseInner(dynamic value) {
    //input can not be null here, because [_parser] is invoked by [parse]
    if (value is double) {
      return Left(value.round());
    } else if (value is int) {
      return Left(value);
    } else if (value is String) {
      var suffix = endsWithSuffix(value, allowedSuffixes);

      var inputWithoutSuffix = value.substring(0, value.length - (suffix?.length ?? 0));

      var result = int.tryParse(inputWithoutSuffix);
      if (result == null) {
        return Right(ParsingError("Could not parse int. Value for '$key' was String: $value"));
      } else {
        return Left(result);
      }
    } else {
      return Right(ParsingError("Could not parse int. Value for '$key' was: $value, type: ${value.runtimeType}"));
    }
  }
}
