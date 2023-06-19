import 'dart:core';

import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';
import 'package:openral_flutter/cross/backend/parsing/parsing_error.dart';

abstract class ParsableField<T> {
  final String key;

  ///if [isRequired] is true, the field must be given. [defaultValue] is ignored
  final bool isRequired;

  ///optional default value, if [isRequired] is false and value is null
  final T? defaultValue;

  Type get genericType => T;

  const ParsableField(
    this.key, {
    this.isRequired = true,
    this.defaultValue,
  });

  Either<T, ParsingError> parse(dynamic input) {
    if (input == null) {
      if (isRequired == true) {
        return Right(ParsingError("'$key' is required, but was null"));
      } else {
        if (defaultValue == null && isNullable == false) {
          return Right(ParsingError("'$key' is optional, but default value is null and type $T is not nullable"));
        } else {
          return Left(defaultValue as T);
        }
      }
    } else {
      var parsingResult = parseInner(input);
      if (parsingResult.isRight) {
        return Right(parsingResult.right);
      } else {
        return Left(parsingResult.left);
      }
    }
  }

  @protected
  Either<T, ParsingError> parseInner(dynamic value);

  bool get isNullable {
    try {
      // throws an exception if T is not nullable
      // ignore: unused_local_variable
      var value = null as T;
      return true;
    } catch (_) {
      return false;
    }
  }
}
