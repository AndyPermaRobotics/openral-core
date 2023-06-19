import 'package:either_dart/either.dart';
import 'package:openral_flutter/cross/backend/parsing/parseable_field.dart';
import 'package:openral_flutter/cross/backend/parsing/parser_factory.dart';
import 'package:openral_flutter/cross/backend/parsing/parsing_error.dart';

class ParsableFieldNested<T> extends ParsableField<T?> {
  final ParserFactory<T> parserFactory;

  const ParsableFieldNested(
    String key, {
    required this.parserFactory,
    super.isRequired = true,
    super.defaultValue,
  }) : super(key);

  @override
  Either<T, ParsingError> parseInner(dynamic value) {
    return parserFactory.fromMap(value);
  }
}
