from typing import Callable, Dict, List, Optional, TypeVar

from openral_py.model.ral_object import RalObject
from openral_py.model.specific_properties import SpecificProperties
from openral_py.repository.ral_object_repository import RalObjectRepository

#todo generics
S = TypeVar('S', bound=SpecificProperties)

class MockRalObjectRepository(RalObjectRepository):
    """
    A mock implementation of [RalRepository] that stores [RalObject]s in memory.
    """
    def __init__(self, docs_by_uid: Dict[str, dict], docs_by_container_id: Dict[str, List[str]]) -> None:
        self.docs_by_uid = docs_by_uid
        self.docs_by_container_id = docs_by_container_id
    
    async def get_by_uid(self, uid: str, specificPropertiesTransform: Optional[Callable] = None) -> RalObject:
        doc = self.docs_by_uid.get(uid)
        
        if not doc:
            raise Exception(f"No RalObject found for uid '{uid}'")
        
        ral_object = RalObject.from_map(doc)
        
        return ral_object
    
    async def get_by_container_id(self, containerId: str) -> List[RalObject]:
        uids = self.docs_by_container_id.get(containerId)
        
        if not uids:
            return []
        
        result = []
        
        for uid in uids:
            object = await self.get_by_uid(uid)
            result.append(object)
        
        return result
    
    async def get_by_ral_type(self, ralType: str) -> List[RalObject]:
        result = []
        
        for uid in self.docs_by_uid:
            object = await self.get_by_uid(uid)
            
            if object.template.ral_type == ralType:
                result.append(object)
        
        return result

    async def create(self, ral_object: RalObject, override_if_exists: bool):
        
        if not override_if_exists and self.docs_by_uid.get(ral_object.identity.uid):
            raise Exception(f"RalObject with uid '{ral_object.identity.uid}' already exists.")
        
        self.docs_by_uid[ral_object.identity.uid] = ral_object.to_map()

        # add the uid to docs_by_container_id if it has a container.UID
        if ral_object.current_geo_location.container:
            container_id = ral_object.current_geo_location.container.uid

            if not self.docs_by_container_id.get(container_id):
                self.docs_by_container_id[container_id] = []

            if ral_object.identity.uid  not in self.docs_by_container_id[container_id]:
                self.docs_by_container_id[container_id].append(ral_object.identity.uid)

        