import 'package:either_dart/src/either.dart';
import 'package:openral_core/src/cross/backend/parsing/parseable_field.dart';
import 'package:openral_core/src/cross/backend/parsing/parsing_error.dart';

class ParsableFieldEnum<T extends Enum> extends ParsableField<T?> {
  final Map<String, T>? translationMap;
  final T Function(String input)? byName;

  /// Can be used to derive the possible input values for this field programmatically e.g. for automatic tests or UI Components
  /// In a better world we could get the possibleValues directly from T, but Dart does not allow this
  /// Most of the time it will be: `ExampleEnum.values.map((e) => e.name).toList(),`
  final List<String> possibleValues;

  ///TODO: Maybe we can add a flag to allow an automatic translation of lowerCamelCase to SNAKE_CASE, otherwise its quite cumbersome and susceptible for errors

  ///[translationMap] can be used to add custom translations
  ///us [byName] to pass the byName function of the enum e.g. `ExampleEnum.values.byName`
  const ParsableFieldEnum(
    String key, {
    super.isRequired = true,
    super.defaultValue,
    this.translationMap,
    required this.byName,
    required this.possibleValues,
  })  : assert(translationMap != null || byName != null),
        super(key);

  @override
  Either<T, ParsingError> parseInner(dynamic value) {
    if (value is String) {
      T? translatedValue;

      String? byNameErrorMessage;

      if (translationMap != null) {
        translatedValue = translationMap![value];
      }
      if (byName != null) {
        try {
          translatedValue = byName!(value);
        } catch (e) {
          byNameErrorMessage = e.toString();
        }
      }

      if (translatedValue != null) {
        return Left(translatedValue);
      } else {
        if (byNameErrorMessage != null) {
          return Right(ParsingError("Expected value for $key to be translatable by $byName, but got error: $byNameErrorMessage"));
        } else {
          return Right(ParsingError("Expected value for $key to be translatable by a value in $translationMap but value was $value"));
        }
      }
    } else {
      return Right(ParsingError("Expected value for $key to be a String, but was $value(${value.runtimeType})"));
    }
  }
}
