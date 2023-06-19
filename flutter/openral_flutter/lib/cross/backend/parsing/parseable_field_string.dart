import 'package:either_dart/either.dart';
import 'package:openral_flutter/cross/backend/parsing/parseable_field.dart';
import 'package:openral_flutter/cross/backend/parsing/parsing_error.dart';

class ParsableFieldString extends ParsableField<String?> {
  const ParsableFieldString(
    String key, {
    super.isRequired = true,
    super.defaultValue,
  }) : super(key);

  @override
  Either<String, ParsingError> parseInner(dynamic value) {
    if (value is String) {
      return Left(value);
    } else {
      return Right(ParsingError("Expected String for '$key', but got $value, ${value.runtimeType}"));
    }
  }
}
