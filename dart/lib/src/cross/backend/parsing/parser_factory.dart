import 'package:either_dart/either.dart';
import 'package:openral_core/src/cross/backend/parsing/map_parser.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parsing_error.dart';

///Parsing of each field that [getFields] returns and invokes the [create] method with the results
///[getFields] should include everything, that the Object that [create] returns need to be constructed
abstract class ParserFactory<T> {
  const ParserFactory();

  //! Gefällt mir noch nicht so ganz, dass man hier nicht programmatisch die Möglichkeiten der Eingaben bestimmen kann. also die verschiedenen Typen
  //This can be used to return dynamic lists of parsable fields that are allowed for the current map (e.g. to determine a type field)
  //normally should be used to determine Fields for different subclasses of T
  List<ParsableField> getFields(dynamic map);

  Either<T, ParsingError> fromMap(dynamic map) {
    var parsedValuesResult = MapParser.parse(map, getFields(map));

    if (parsedValuesResult.isRight) {
      return Right(ParsingError("$T could not be parsed:\n\t${parsedValuesResult.right.message}"));
    } else {
      var parsedValues = parsedValuesResult.left;
      return Left(create(parsedValues));
    }
  }

  //must be implemented to create an object of type T, normally it just invokes the constructor
  //TODO: @protected
  T create(Map<ParsableField<dynamic>, dynamic> parsedValues);
}
