from typing import Any, Dict, Optional


class SpecificProperty:
    def __init__(self, key: str, value: Any, unit: Optional[str] = None):
        self.key = key
        self.value = value
        self.unit = unit

    def to_map(self):
        return {
            'key': self.key,
            'value': self.value,
            'unit': self.unit,
        }
    
    @staticmethod
    def from_map(property_map: Dict[str, Any]) -> 'SpecificProperty':
        key = property_map['key']
        value = property_map['value']

        unit = None
        if 'unit' in property_map:
            unit = property_map['unit']

        return SpecificProperty(key, value, unit)
