from abc import ABC, abstractmethod
from typing import Any, Dict, List, Optional

from openral_py.model.definition import Definition
from openral_py.model.identity import Identity
from openral_py.model.object_ref import ObjectRef
from openral_py.model.ral_object import RalObject
from openral_py.model.ral_object_with_role import RalObjectWithRole
from openral_py.model.specific_properties import SpecificProperties
from openral_py.model.template import Template


class RalMethod:
    identity: Identity
    definition: Definition
    template: Template
    method_state: str
    specific_properties: SpecificProperties
    input_objects: List[RalObjectWithRole]
    output_objects: List[RalObject]
    nested_methods: List["RalMethod"]
    input_objects_ref: List[ObjectRef]
    output_objects_ref: List[ObjectRef]

    def __init__(
        self,
        identity: Identity,
        definition: Definition,
        template: Template,
        method_state: str,
        specific_properties: SpecificProperties,
        input_objects: List[RalObjectWithRole],
        output_objects: List[RalObject],
        nested_methods: List["RalMethod"],
        input_objects_ref: List[ObjectRef],
        output_objects_ref: List[ObjectRef]
    ) -> None:
        self.identity = identity
        self.definition = definition
        self.template = template
        self.method_state = method_state
        self.specific_properties = specific_properties
        self.input_objects = input_objects
        self.output_objects = output_objects
        self.nested_methods = nested_methods
        self.input_objects_ref = input_objects_ref
        self.output_objects_ref = output_objects_ref

    def to_map(self) -> Dict[str, Any]:
        return {
            "identity": self.identity.to_map(),
            "definition": self.definition.to_map(),
            "template": self.template.to_map(),
            "methodState": self.method_state,
            "specificProperties": self.specific_properties.to_maps(),
            "inputObjects": [input_object.to_map() for input_object in self.input_objects],
            "outputObjects": [output_object.to_map() for output_object in self.output_objects],
            "nestedMethods": [nested_method.to_map() for nested_method in self.nested_methods],
            "inputObjectsRef": [input_object_ref.to_map() for input_object_ref in self.input_objects_ref],
            "outputObjectsRef": [output_object_ref.to_map() for output_object_ref in self.output_objects_ref]
        }

    @staticmethod
    def from_map(map: Dict[str, Any]) -> "RalMethod":
        identity = Identity.from_map(map["identity"])
        definition = Definition.from_map(map["definition"])
        template = Template.from_map(map["template"])
        method_state = map.get("methodState", "undefined")
        specific_properties = SpecificProperties.from_maps(map["specificProperties"])

        input_objects: List[RalObjectWithRole] = []
        if map.get("inputObjects") is not None:
            input_objects = [RalObjectWithRole.from_map(input_object) for input_object in map["inputObjects"]]

        output_objects: List[RalObject] = []
        if map.get("outputObjects") is not None:
            output_objects = [RalObject.from_map(output_object) for output_object in map["outputObjects"]]

        nested_methods: List[RalMethod] = []
        if map.get("nestedMethods") is not None:
            nested_methods = [RalMethod.from_map(nested_method) for nested_method in map["nestedMethods"]]

        input_objects_ref: List[ObjectRef] = []
        if map.get("inputObjectsRef") is not None:
            input_objects_ref = [ObjectRef.from_map(input_object_ref) for input_object_ref in map["inputObjectsRef"]]

        output_objects_ref: List[ObjectRef] = []
        if map.get("outputObjectsRef") is not None:
            output_objects_ref = [ObjectRef.from_map(output_object_ref) for output_object_ref in map["outputObjectsRef"]]

        return RalMethod(
            identity=identity,
            definition=definition,
            template=template,
            method_state=method_state,
            specific_properties=specific_properties,
            input_objects=input_objects,
            output_objects=output_objects,
            nested_methods=nested_methods,
            input_objects_ref=input_objects_ref,
            output_objects_ref=output_objects_ref
        )