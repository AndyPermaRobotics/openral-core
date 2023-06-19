import 'package:either_dart/either.dart';
import 'package:openral_flutter/cross/backend/parsing/parseable_field.dart';
import 'package:openral_flutter/cross/backend/parsing/parsing_error.dart';

class ParsableFieldCustomSimple<T> extends ParsableField<T> {
  final Either<T, ParsingError> Function(dynamic raw) parserFunc;

  const ParsableFieldCustomSimple(
    String key, {
    required this.parserFunc,
    super.isRequired = true,
    super.defaultValue,
  }) : super(key);

  @override
  Either<T, ParsingError> parseInner(dynamic value) {
    return parserFunc(value);
  }
}
