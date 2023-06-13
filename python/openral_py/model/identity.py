

from typing import Any, Dict, Optional


class Identity:
    def __init__(
        self, 
        uid: str, 
        name: Optional[str] = None, 
        site_tag: Optional[str] = None, 
        alternateIDs: list = [], 
        alternateNames: list = []
    ):
        self.uid = uid
        self.name = name
        self.site_tag = site_tag
        self.alternate_ids = alternateIDs
        self.alternate_names = alternateNames

    def to_map(self):
        return {
            "UID": self.uid,
            "name": self.name,
            "siteTag": self.site_tag,
            "alternateIDs": self.alternate_ids,
            "alternateNames": self.alternate_names,
        }
    
    @staticmethod
    def from_map(data: Dict[str, Any]):
        return Identity(
            uid=data["UID"],
            name=data.get("name"),
            site_tag=data.get("siteTag"),
            alternateIDs=data.get("alternateIDs", []),
            alternateNames=data.get("alternateNames", []),
        )