
from typing import Callable

from openral_py.model.current_geo_location import CurrentGeoLocation
from openral_py.model.definition import Definition
from openral_py.model.identity import Identity
from openral_py.model.specific_properties import SpecificProperties
from openral_py.model.template import Template


class RalObject:
    """
    represents the base class for RAL objects
    Represents a json object like this:
    ```json
    {
        "identity": {
            "UID": "",
            "name": "thing",
            "siteTag": "",
            "alternateIDs": [],
            "alternateNames": []
        },
        "currentOwners": [],
        "definition": {
            "definitionText": "An object or entity that is not or cannot be named specifically",
            "definitionURL": "https://www.thefreedictionary.com/thing"
        },
        "objectState": "undefined",
        "template": {
            "RALType": "thing",
            "version": "1",
            "objectStateTemplates": "generalObjectState"
        },
        "specificProperties": [
            {
            "key": "serial number",
            "value": "",
            "unit": "String"
            }
        ],
        "currentGeolocation": {
            "container": {
            "UID": "unknown"
            },
            "postalAddress": {
            "country": "unknown",
            "cityName": "unknown",
            "cityNumber": "unknown",
            "streetName": "unknown",
            "streetNumber": "unknown"
            },
            "3WordCode": "unknown",
            "geoCoordinates": {
            "longitude": 0,
            "latitude": 0
            },
            "plusCode": "unknown"
        },
        "locationHistoryRef": [],
        "ownerHistoryRef": [],
        "methodHistoryRef": [],
        "linkedObjectRef": []
    }
```
    
    """
    def __init__(
            self, 
            identity: Identity, 
            definition: Definition,  
            template: Template, 
            specific_properties: SpecificProperties, 
            current_geo_location: CurrentGeoLocation = CurrentGeoLocation(), 
            current_owners: list[str] = [], 
            object_state: str = "undefined", 
            location_history_ref: list[str] = [], 
            owner_history_ref: list[str] = [], 
            method_history_ref: list[str] = [], 
            linked_object_ref: list[str] = []
        ):
        self.identity = identity
        self.current_owners = current_owners
        self.definition = definition
        self.object_state = object_state
        self.template = template
        self._specificProperties = specific_properties
        self.current_geo_location = current_geo_location
        self.location_history_ref = location_history_ref
        self.owner_history_ref = owner_history_ref
        self.method_ristory_ref = method_history_ref
        self.linked_object_ref = linked_object_ref
    
    @property
    def specific_properties(self):
        return self._specificProperties

    def transformTo(self, specificPropertiesTransform: Callable) -> 'RalObject':
        return RalObject(
            identity=self.identity,
            current_owners=self.current_owners,
            definition=self.definition,
            object_state=self.object_state,
            template=self.template,
            specific_properties=specificPropertiesTransform(self._specificProperties),
            current_geo_location=self.current_geo_location,
            location_history_ref=self.location_history_ref,
            owner_history_ref=self.owner_history_ref,
            method_history_ref=self.method_ristory_ref,
            linked_object_ref=self.linked_object_ref
        )

    def to_map(self) -> dict:
        return {
            "identity": self.identity.to_map(),
            "currentOwners": self.current_owners,
            "definition": self.definition.to_map(),
            "objectState": self.object_state,
            "template": self.template.to_map(),
            "specificProperties": self.specific_properties.to_maps(),
            "currentGeolocation": self.current_geo_location.to_map(),
            "locationHistoryRef": self.location_history_ref,
            "ownerHistoryRef": self.owner_history_ref,
            "methodHistoryRef": self.method_ristory_ref,
            "linkedObjectRef": self.linked_object_ref
        }
    
    @staticmethod
    def from_map(map: dict) -> 'RalObject':
    
        identity = Identity.from_map(map.get("identity", {}))

        current_owners = map.get("currentOwners", [])
        definition = Definition.from_map(map.get("definition", {}))
        object_state = map.get("objectState", "undefined")
        template = Template.from_map(map.get("template", {}))
        specific_properties = SpecificProperties.from_maps(map.get("specificProperties", []))
        current_geo_location = CurrentGeoLocation.from_map(map.get("currentGeolocation", {}))
        location_history_ref = map.get("locationHistoryRef", [])
        owner_history_ref = map.get("ownerHistoryRef", [])
        method_history_ref = map.get("methodHistoryRef", [])
        linked_object_ref = map.get("linkedObjectRef", [])

        return RalObject(
            identity=identity,
            current_owners=current_owners,
            definition=definition,
            object_state=object_state,
            template=template,
            specific_properties=specific_properties,
            current_geo_location=current_geo_location,
            location_history_ref=location_history_ref,
            owner_history_ref=owner_history_ref,
            method_history_ref=method_history_ref,
            linked_object_ref=linked_object_ref
        )