from typing import Any, Dict

import pytest

from openral_py.model.identity import Identity


class TestIdentity:
    @staticmethod
    def from_map(data):
        return Identity(
            uid=data.get("UID"),
            name=data.get("name"),
            site_tag=data.get("siteTag"),
            alternateIDs=data.get("alternateIDs", []),
            alternateNames=data.get("alternateNames", []),
        )

    def test_from_map_with_empty_data(self):
        # arrange
        data = {}

        # act
        identity = self.from_map(data)

        # assert
        assert identity.uid is None
        assert identity.name is None
        assert identity.site_tag is None
        assert identity.alternate_ids == []
        assert identity.alternate_names == []

    def test_from_map_with_full_data(self):
        # arrange
        data : Dict[str, Any] = {
            "UID": 123,
            "name": "John",
            "siteTag": "example.com",
            "alternateIDs": [456, 789],
            "alternateNames": ["Johnny"],
        }

        # act
        identity = self.from_map(data)

        # assert
        assert identity.uid == 123
        assert identity.name == "John"
        assert identity.site_tag == "example.com"
        assert identity.alternate_ids == [456, 789]
        assert identity.alternate_names == ["Johnny"]