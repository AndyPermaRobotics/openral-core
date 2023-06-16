

from typing import Any, Dict

from openral_py.model.owner_ref import OwnerRef


class TestOwnerRef:
    
    def test_from_map_with_full_data(self):
        # arrange
        data : Dict[str, Any] = {
            "UID": "123",
            "RALType": "type",
        }

        # act
        identity = OwnerRef.from_map(data)

        # assert
        assert identity.uid == "123"
        assert identity.ral_type == "type"

    def test_to_map(self):
        # arrange
        owner_ref = OwnerRef("123", "type")

        # act
        data = owner_ref.to_map()

        # assert
        assert data == {
            "UID": "123",
            "RALType": "type",
        }