import 'package:either_dart/either.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parsing_error.dart';

class ParsableFieldDynamic extends ParsableField<dynamic> {
  const ParsableFieldDynamic(
    String key, {
    super.isRequired = true,
    super.defaultValue,
  }) : super(key);

  @override
  Either<dynamic, ParsingError> parseInner(dynamic value) {
    ///no checks necessary here.
    ///The value is already dynamic and can be anything.
    ///'required' condition is checked by the [ParsableField] class
    return Left(value);
  }
}
