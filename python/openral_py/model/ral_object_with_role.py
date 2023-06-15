from typing import Any, Optional

from openral_py.model.current_geo_location import CurrentGeoLocation
from openral_py.model.definition import Definition
from openral_py.model.identity import Identity
from openral_py.model.specific_properties import SpecificProperties
from openral_py.model.specific_property import SpecificProperty
from openral_py.model.template import Template
from openral_py.ral_object import RalObject

__all__ = ["CurrentGeoLocation", "Definition", "Identity", "SpecificProperties", "Template", "SpecificProperty", "RalObject"]


class RalObjectWithRole(RalObject):

    def __init__(
        self,
        role: str,
        identity: Identity,
        definition: Definition,
        template: Template,
        specific_properties: SpecificProperties,
        current_geo_location: CurrentGeoLocation,
        current_owners: list[str] = [],
        object_state: str =  "undefined",
        location_history_ref: list[str] = [],
        owner_history_ref: list[str] = [],
        method_history_ref: list[str] = [],
        linked_object_ref: list[str] = [],
    ) -> None:
        super().__init__(
            identity=identity,
            definition=definition,
            template=template,
            specific_properties=specific_properties,
            current_geo_location=current_geo_location,
            current_owners=current_owners,
            object_state=object_state,
            location_history_ref=location_history_ref,
            owner_history_ref=owner_history_ref,
            method_history_ref=method_history_ref,
            linked_object_ref=linked_object_ref,
        )
        self.role = role

    def to_map(self) -> dict[str, Any]:
        map = super().to_map()
        map["role"] = self.role
        return map

    @staticmethod
    def from_ral_object_plus_role(object: RalObject, role: str) -> "RalObjectWithRole":
        return RalObjectWithRole(
            role,
            object.identity,
            object.definition,
            object.template,
            object.specific_properties,
            object.current_geo_location,
            object.current_owners,
            object.object_state,
            object.location_history_ref,
            object.owner_history_ref,
            object.method_ristory_ref,
            object.linked_object_ref,
        )

    @staticmethod
    def from_map(map_: dict[str, Any]) -> "RalObjectWithRole":
        object_ = RalObject.from_map(map_)
        role = map_.get("role")

        if role is None:
            raise ValueError("role is not defined in the map")
        elif not isinstance(role, str):
            raise TypeError("role is not a string")
        elif len(role) == 0:
            raise ValueError("role is an empty string")

        return RalObjectWithRole.from_ral_object_plus_role(object_, role)