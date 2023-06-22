import 'package:either_dart/either.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parsing_error.dart';

class ParsableFieldCustom<T> extends ParsableField<T?> {
  final Either<T, ParsingError> Function(dynamic raw) parserFunc;

  //If T has properties themself, they can be received through nestedFields
  final List<ParsableField> nestedFields;

  const ParsableFieldCustom(
    String key, {
    required this.parserFunc,
    required this.nestedFields,
    super.isRequired = true,
    super.defaultValue,
  }) : super(key);

  @override
  Either<T, ParsingError> parseInner(dynamic value) {
    return parserFunc(value);
  }
}
