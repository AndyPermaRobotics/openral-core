from typing import Any, Dict, Optional


class OwnerRef:
    """Reference to a RAL object that is an owner of another RAL object."""
    uid: str
    ral_type: Optional[str]

    def __init__(self, uid: str, ral_type: Optional[str]) -> None:
        self.uid = uid
        self.ral_type = ral_type
        #todo: the data at which the ownership started (how is it called and what type is it?)

    def to_map(self) -> Dict[str, Any]:
        return {
            "UID": self.uid,
            "RALType": self.ral_type
        }

    @staticmethod
    def from_map(map_: Dict[str, Any]) -> "OwnerRef":
        uid = map_.get("UID")
        ral_type = map_.get("RALType")

        if uid is None:
            raise ValueError("UID is required")
        elif not isinstance(uid, str):
            raise TypeError("UID must be a string")

        return OwnerRef(uid, ral_type)