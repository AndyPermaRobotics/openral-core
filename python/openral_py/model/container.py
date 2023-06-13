from typing import Any, Dict


class Container:
    def __init__(self, uid: str):
        self.uid = uid

    def to_map(self):
        return {
            'UID': self.uid,
        }

    @staticmethod
    def from_map(data: Dict[str, Any]) -> 'Container':
        uid = data['UID'] #throws Keyerror if UID is not present
        return Container(uid=uid)