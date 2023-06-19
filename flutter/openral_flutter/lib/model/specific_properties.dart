import 'package:either_dart/either.dart';
import 'package:openral_flutter/cross/backend/parsing/parsing_error.dart';
import 'package:openral_flutter/model/specific_property.dart';
import 'package:openral_flutter/model_parser/specific_properties_parser.dart';

class SpecificProperties {
  final Map<String, SpecificProperty> _specificProperties;

  SpecificProperties(this._specificProperties);

  ///returns the value of the specific property with the given key or null if the property does not exist
  dynamic operator [](String key) => _specificProperties[key]?.value;

  bool containsKey(String key) {
    return _specificProperties.containsKey(key);
  }

  ///returns the specific property with the given key or null, if it does not exist
  SpecificProperty? get(String key) {
    return _specificProperties[key];
  }

  Map<String, SpecificProperty> get map => Map.fromEntries(_specificProperties.entries);

  ///returns [SpecificProperty]s as list of maps
  List<Map<String, dynamic>> toMaps() {
    return _specificProperties.values
        .map<Map<String, dynamic>>(
          (value) => value.toMap(),
        )
        .toList();
  }

  static Either<SpecificProperties, ParsingError> fromMaps(dynamic input) {
    final specificPropertiesParser = SpecificPropertiesParser();

    return specificPropertiesParser.parse(input);
  }
}
