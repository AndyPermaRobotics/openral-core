import 'package:openral_core/src/model/definition.dart';
import 'package:openral_core/src/model/identity.dart';
import 'package:openral_core/src/model/object_ref.dart';
import 'package:openral_core/src/model/ral_object.dart';
import 'package:openral_core/src/model/ral_object_with_role.dart';
import 'package:openral_core/src/model/specific_properties.dart';
import 'package:openral_core/src/model/template.dart';

class RalMethod {
  Identity identity;
  Definition definition;
  Template template;
  String methodState;
  SpecificProperties specificProperties;
  List<RalObjectWithRole> inputObjects;
  List<RalObject> outputObjects;
  List<RalMethod> nestedMethods;
  List<ObjectRef> inputObjectsRef;
  List<ObjectRef> outputObjectsRef;

  RalMethod({
    required this.identity,
    required this.definition,
    required this.template,
    required this.methodState,
    required this.specificProperties,
    required this.inputObjects,
    required this.outputObjects,
    required this.nestedMethods,
    required this.inputObjectsRef,
    required this.outputObjectsRef,
  });

  Map<String, dynamic> toMap() {
    return {
      "identity": identity.toMap(),
      "definition": definition.toMap(),
      "template": template.toMap(),
      "methodState": methodState,
      "specificProperties": specificProperties.toMaps(),
      "inputObjects": inputObjects.map((inputObject) => inputObject.toMap()).toList(),
      "outputObjects": outputObjects.map((outputObject) => outputObject.toMap()).toList(),
      "nestedMethods": nestedMethods.map((nestedMethod) => nestedMethod.toMap()).toList(),
      "inputObjectsRef": inputObjectsRef.map((inputObjectRef) => inputObjectRef.toMap()).toList(),
      "outputObjectsRef": outputObjectsRef.map((outputObjectRef) => outputObjectRef.toMap()).toList(),
    };
  }

  static RalMethod fromMap(Map<String, dynamic> map) {
    final identityResult = Identity.fromMap(map["identity"]);
    final definitionResult = Definition.fromMap(map["definition"]);
    final templateResult = Template.fromMap(map["template"]);
    final methodState = map.containsKey("methodState") ? map["methodState"] : "undefined";
    final specificPropertiesResult = SpecificProperties.fromMaps(map["specificProperties"]);

    if (identityResult.isRight) {
      throw Exception("Identity parsing failed: ${identityResult.right}");
    }
    final identity = identityResult.left;

    if (definitionResult.isRight) {
      throw Exception("Definition parsing failed: ${definitionResult.right}");
    }
    final definition = definitionResult.left;

    if (templateResult.isRight) {
      throw Exception("Template parsing failed: ${templateResult.right}");
    }
    final template = templateResult.left;

    if (specificPropertiesResult.isRight) {
      throw Exception("SpecificProperties parsing failed: ${specificPropertiesResult.right}");
    }
    final specificProperties = specificPropertiesResult.left;

    List<RalObjectWithRole> inputObjects = [];
    if (map.containsKey("inputObjects")) {
      inputObjects = map["inputObjects"].map<RalObjectWithRole>((inputObject) => RalObjectWithRole.fromMap(inputObject)).toList();
    }

    List<RalObject> outputObjects = [];
    if (map.containsKey("outputObjects")) {
      outputObjects = map["outputObjects"].map<RalObject>((outputObject) => RalObject.fromMap(outputObject)).toList();
    }

    List<RalMethod> nestedMethods = [];
    if (map.containsKey("nestedMethods")) {
      nestedMethods = map["nestedMethods"].map<RalMethod>((nestedMethod) => RalMethod.fromMap(nestedMethod)).toList();
    }

    List<ObjectRef> inputObjectsRef = [];
    if (map.containsKey("inputObjectsRef")) {
      inputObjectsRef = map["inputObjectsRef"].map<ObjectRef>((inputObjectRef) => ObjectRef.fromMap(inputObjectRef)).toList();
    }

    List<ObjectRef> outputObjectsRef = [];
    if (map.containsKey("outputObjectsRef")) {
      outputObjectsRef = map["outputObjectsRef"].map<ObjectRef>((outputObjectRef) => ObjectRef.fromMap(outputObjectRef)).toList();
    }

    return RalMethod(
      identity: identity,
      definition: definition,
      template: template,
      methodState: methodState,
      specificProperties: specificProperties,
      inputObjects: inputObjects,
      outputObjects: outputObjects,
      nestedMethods: nestedMethods,
      inputObjectsRef: inputObjectsRef,
      outputObjectsRef: outputObjectsRef,
    );
  }
}
