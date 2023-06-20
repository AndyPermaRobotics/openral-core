

from typing import Any, Dict

from openral_py.model.object_ref import ObjectRef


class TestObjectRef:
    
    def test_from_map_with_full_data(self):
        # arrange
        data : Dict[str, Any] = {
            "UID": "123",
            "role": "type",
        }

        # act
        identity = ObjectRef.from_map(data)

        # assert
        assert identity.uid == "123"
        assert identity.role == "type"

    def test_to_map(self):
        # arrange
        owner_ref = ObjectRef("123", "type")

        # act
        data = owner_ref.to_map()

        # assert
        assert data == {
            "UID": "123",
            "role": "type",
        }