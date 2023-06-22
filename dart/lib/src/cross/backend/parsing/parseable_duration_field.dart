import 'package:either_dart/either.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parsing_error.dart';

class ParsableDurationField extends ParsableField<Duration?> {
  //TODO: Maybe we can have .seconds .days .milliseconds etc here to make it easier to get the format

  const ParsableDurationField(
    String key, {
    super.isRequired = true,
    super.defaultValue,
  }) : super(key);

  //Expects [value] to be microseconds of the Duration that should be parsed
  @override
  Either<Duration, ParsingError> parseInner(dynamic value) {
    if (value is int) {
      return Left(Duration(microseconds: value));
    } else {
      return Right(ParsingError("Expected Microseconds as int for '$key', but got $value, ${value.runtimeType}"));
    }
  }
}
