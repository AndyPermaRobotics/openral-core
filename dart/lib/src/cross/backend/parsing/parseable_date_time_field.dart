import 'package:either_dart/either.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parsing_error.dart';

class ParsableDateTimeField extends ParsableField<DateTime?> {
  const ParsableDateTimeField(
    String key, {
    super.isRequired = true,
    super.defaultValue,
  }) : super(key);

  //Expects [value] to be sicrosecondsSinceEpoch of the DateTime that should be parsed
  @override
  Either<DateTime, ParsingError> parseInner(dynamic value) {
    if (value is int) {
      return Left(DateTime.fromMicrosecondsSinceEpoch(value));
    } else {
      try {
        //e.g. Firestore Timestamp
        final dateTime = value.toDate();

        return Left(dateTime);
      } catch (e) {
        return Right(ParsingError("Expected microseconds as int or an object supporting toDate() for '$key', but got $value, ${value.runtimeType}"));
      }
    }
  }
}
