import 'package:either_dart/either.dart';
import 'package:openral_flutter/cross/backend/parsing/parseable_field.dart';
import 'package:openral_flutter/cross/backend/parsing/parsing_error.dart';

class ParsableListField<T> extends ParsableField<List<T>?> {
  final ParsableField singleField;

  const ParsableListField(
    String key, {
    required this.singleField,
    super.isRequired = true,
    super.defaultValue,
  }) : super(key);

  @override
  Either<List<T>, ParsingError> parseInner(dynamic value) {
    if (value is List == false) {
      return Right(ParsingError("ParsableListField: Expected a List, but got '$value'"));
    }

    var elementList = <T>[];
    var parsingErrors = <ParsingError>[];

    var list = value as List;
    for (var v in list) {
      var result = singleField.parse(v);
      if (result.isLeft) {
        elementList.add(result.left);
      } else {
        parsingErrors.add(result.right);
      }
    }

    if (parsingErrors.isEmpty) {
      return Left(elementList);
    } else {
      //TODO: make ParsingError having children

      var composedMessage = parsingErrors.fold<String?>(null, (fold, parsingError) {
        if (fold == null) {
          return "- ${parsingError.message}";
        } else {
          return "$fold\n- ${parsingError.message}";
        }
      });

      return Right(ParsingError("${parsingErrors.length} ParsingErrors of List '$key': \n$composedMessage \n\nvalue was: $value"));
    }
  }
}
