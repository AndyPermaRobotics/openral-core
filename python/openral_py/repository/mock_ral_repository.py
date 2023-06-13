from typing import Callable, Dict, List, Optional, TypeVar

from openral_py.model.specific_properties import SpecificProperties
from openral_py.ral_object import RalObject
from openral_py.repository.ral_repository import RalRepository

#todo generics
S = TypeVar('S', bound=SpecificProperties)

class MockRalRepository(RalRepository):
    """
    A mock implementation of [RalRepository] that stores [RalObject]s in memory.
    """
    def __init__(self, docs_by_uid: Dict[str, dict], docs_by_container_id: Dict[str, List[str]]) -> None:
        self.docsByUid = docs_by_uid
        self.docsByContainerId = docs_by_container_id
    
    async def get_ral_object_by_uid(self, uid: str, specificPropertiesTransform: Optional[Callable] = None) -> RalObject:
        doc = self.docsByUid.get(uid)
        
        if not doc:
            raise Exception(f"No RalObject found for uid '{uid}'")
        
        ral_object = RalObject.from_map(doc)
        
        return ral_object
    
    async def get_ral_objects_with_container_id(self, containerId: str) -> List[RalObject]:
        uids = self.docsByContainerId.get(containerId)
        
        if not uids:
            return []
        
        result = []
        
        for uid in uids:
            object = await self.get_ral_object_by_uid(uid)
            result.append(object)
        
        return result
    
    async def get_ral_objects_by_ral_type(self, ralType: str) -> List[RalObject]:
        result = []
        
        for uid in self.docsByUid:
            object = await self.get_ral_object_by_uid(uid)
            
            if object.template.ral_type == ralType:
                result.append(object)
        
        return result
