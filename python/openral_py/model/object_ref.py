from abc import ABC, abstractmethod
from typing import Any, Dict, Optional, Type


class ObjectRef:
    uid: str
    role: Optional[str]

    def __init__(self, uid: str, role: Optional[str]) -> None:
        self.uid = uid
        self.role = role

    def to_map(self) -> Dict[str, Any]:
        return {
            "UID": self.uid,
            "role": self.role
        }

    @staticmethod
    def from_map(map_: Dict[str, Any]) -> "ObjectRef":
        uid = map_.get("UID")
        role = map_.get("role")

        if uid is None:
            raise ValueError("UID is required")
        elif not isinstance(uid, str):
            raise TypeError("UID must be a string")

        return ObjectRef(uid, role)