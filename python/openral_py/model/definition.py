from typing import Any, Dict, Optional


class Definition:
    def __init__(self, definition_text: Optional[str] = None, definition_url: Optional[str] = None):
        self.definition_text = definition_text
        self.definition_url = definition_url

    def to_map(self):
        return {
            'definitionText': self.definition_text,
            'definitionURL': self.definition_url,
        }
    
    @staticmethod
    def from_map(data: Dict[str, Any]) -> 'Definition':
        definition_text = data.get('definitionText')
        definition_url = data.get('definitionURL')

        return Definition(definition_text=definition_text, definition_url=definition_url)