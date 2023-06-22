# openRAL Flutter

This package contains reusable components to work with openRAL in Flutter and Dart projects.

For more informations about openRAL see: https://open-ral.io/

## Getting Started

### Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  openral_core: 
    git: 
        url: git@github.com:AndyPermaRobotics/openral-core.git
        path: dart
```

If you need a specific version of the package, refer to the [pubspec documentation for git packages](https://dart.dev/tools/pub/dependencies#git-packages) for more details.


## Usage

### RalObject

You can use the RalObject to represent a RalObject in your Flutter app and access it's properties.
You can parse a RalObject from a JSON string or from a Map<String, dynamic> object.

```dart
import 'package:convert';
import 'package:openral_core/src/openral_core.dart';

// Parse from JSON string
String jsonString = '...';

final map = json.decode(jsonString);

result = RalObject.fromMap(map);

if(result.isLeft) {
  RalObject ralObject = result.left;

  print("Name: ${ralObject.identity.name}");

}
else {
  //ParsingError
}

```

#### SpecificProperties

You can the value of specific properties by using the [] operator of the specificProperties field.

```dart
import 'package:openral_core/src/openral_core.dart';

final myRalObject = RalObject(...)

final value = myRalObject.specificProperties["myProperty"];

```

You can also use a Generic with a subclass of SpecificProperties to access the properties with getter methods.

```dart
class MySpecificProperties extends SpecificProperties {
  MySpecificProperties(super.specificProperties);

  //getter method to access the value of the property 'myProperty'
  String get myPropertyValue => this["myProperty"];

  //other methods are also possible
  //we can also converty the value to a specific type based on the unit of the specificproperty
}

final myRalObject = RalObject<MySpecificProperties>() //notice the '<MySpecificProperties>' generic

final value = myRalObject.specificProperties.myPropertyValue;

```

you can also define a `typedef` for RalObject<MySpecificProperties>

```dart
typedef MyRalObject = RalObject<MySpecificProperties>;

final myRalObject = MyRalObject()
```

Parsing is a bit complicated, because Dart can not know that MySpecificProperties only adds some getter methods, but does not change the structure of the SpecificProperties class.

```dart

RalObject.fromMap<SoftwareComponentSpecificProperties>(
  map,
  (SpecificProperties specificProperties) => MySpecificProperties(specificProperties.map),
);
```

the second argumet creates a new instance of MySpecificProperties with the map of the SpecificProperties class.

