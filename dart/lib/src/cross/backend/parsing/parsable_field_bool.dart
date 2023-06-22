import 'package:either_dart/either.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parsing_error.dart';

class ParsableFieldBool extends ParsableField<bool?> {
  const ParsableFieldBool(
    String key, {
    super.isRequired = true,
    super.defaultValue,
  }) : super(key);

  @override
  Either<bool, ParsingError> parseInner(dynamic value) {
    if (value is bool) {
      return Left(value);
    } else if (value is String) {
      if (value.toLowerCase() == "true") {
        return const Left(true);
      } else if (value.toLowerCase() == "false") {
        return const Left(false);
      } else {
        return Right(ParsingError("Could not cast the given String to a bool. Expected one of [true, True, false, False] but got: $value"));
      }
    } else {
      return Right(ParsingError("Expected bool or String for '$key', but got $value, ${value.runtimeType}"));
    }
  }
}
