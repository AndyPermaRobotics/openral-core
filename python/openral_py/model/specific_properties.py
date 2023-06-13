from typing import Any, Dict, List, Optional

from openral_py.model.specific_property import SpecificProperty


class SpecificProperties:
    def __init__(self, specific_properties: Dict[str, SpecificProperty]):
        self._specific_properties = specific_properties

    def __getitem__(self, key: str) -> Optional[Any]:
        specific_property = self._specific_properties.get(key, None)
        return specific_property.value if specific_property is not None else None
        
    def contains_key(self, key: str) -> bool:
        return key in self._specific_properties

    def get(self, key: str) -> Optional[SpecificProperty]:
        return self._specific_properties.get(key, None)

    @property
    def map(self) -> Dict[str, SpecificProperty]:
        return self._specific_properties.copy()

    def to_maps(self) -> List[Dict[str, Any]]:
        return [value.to_map() for value in self._specific_properties.values()]

    
    @staticmethod
    def from_maps(data: Any) -> 'SpecificProperties':
        """Creates a SpecificProperties object from a list of dicts.
        
        Args:
            e.g.:
            [
                {
                    'key': 'key1',
                    'value': 'value1',
                    'unit': 'unit1',
                },
                {
                    'key': 'key2',
                    'value': 'value2',
                    #no unit here
                },
            ]    

        """

        if data is None:
            return SpecificProperties({})
        
        if not isinstance(data, list):
            raise ValueError(f"data must be a list, but was {type(data)}")

        #iterate over the list and create a dict of SpecificProperty objects
        specific_properties : Dict[str, SpecificProperty] = {}
        for item in data:
            if not isinstance(item, dict):
                raise ValueError(f"item must be a dict, but was {type(item)}")
            specific_property = SpecificProperty.from_map(item)
            specific_properties[specific_property.key] = specific_property


        return SpecificProperties(specific_properties)
