import 'package:collection/collection.dart';
import 'package:either_dart/either.dart';
import 'package:openral_flutter/cross/backend/parsing/parseable_field.dart';
import 'package:openral_flutter/cross/backend/parsing/parsing_error.dart';

class ParsableFieldDouble extends ParsableField<double?> {
  ///is useful for parsing e.g. "320px" to 320.0
  final List<String> allowedSuffixes;

  //returns the element from [suffixes] that [value] ends with, or null, if value does not end with any of them
  static String? endsWithSuffix(String value, List<String> suffixes) {
    return suffixes.firstWhereOrNull((suffix) => value.endsWith(suffix));
  }

  const ParsableFieldDouble(
    String key, {
    this.allowedSuffixes = const <String>[],
    super.isRequired = true,
    super.defaultValue,
  }) : super(key);

  @override
  Either<double, ParsingError> parseInner(dynamic input) {
    //input can not be null here, because [_parser] is invoked by [parse]
    if (input is double) {
      return Left(input);
    } else if (input is int) {
      return Left(input.toDouble());
    } else if (input is String) {
      var suffix = endsWithSuffix(input, allowedSuffixes);

      var inputWithoutSuffix = input.substring(0, input.length - (suffix?.length ?? 0));

      var result = double.tryParse(inputWithoutSuffix);
      if (result == null) {
        return Right(ParsingError("Could not parse double. Value for '$key' was String: '$input'"));
      } else {
        return Left(result);
      }
    } else {
      return Right(ParsingError("Could not parse double. Value for '$key' was: '$input', type: '${input.runtimeType}'"));
    }
  }
}
