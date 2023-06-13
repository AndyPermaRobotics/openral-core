
import pytest

from openral_py.discovery.discovery import Discovery
from tests.discovery.mock_data import MockDataLocal


class TestDiscovery:
    

    @pytest.mark.asyncio
    async def test_discovery(self):
        """
        Tests the discovery algorithm with a mock repository.
        """

        # Arrange
        ral_repository = MockDataLocal.getMockRalRepository()

        # Act
        discovery = Discovery(
            ral_repository= ral_repository,
            start_object= await ral_repository.get_ral_object_by_uid("mqtt_child"), #we start with a leaf node
            root_node_ral_type= "pc_instance" #we want to find the root node of the tree that has this ral type
        )

        result = await discovery.execute()

        # Assert
        assert result.data.template.ral_type == "pc_instance", "The root node should have the ral type 'pc_instance'"
        assert result.data.identity.uid == "me_pc", "The root node should have the uid 'me_pc'"

        assert len(result.children) == 2, "The root node should have 2 children"

        assert len(result.get_descendants()) == 3, "The root node should have 3 descendants"

    @pytest.mark.asyncio
    async def test_discovery_fails_to_find_root(self):
        """
        Tests the discovery algorithm with a mock repository.
        """

        # Arrange
        ral_repository = MockDataLocal.getMockRalRepository()

        # Act
        discovery = Discovery(
            ral_repository= ral_repository,
            start_object= await ral_repository.get_ral_object_by_uid("mqtt_child"), #we start with a leaf node
            root_node_ral_type= "" #this type does not exist in the mock data
        )

        # Assert
        with pytest.raises(Exception) as e:
            await discovery.execute()
                
        assert str(e.value) == "No RalObject found for uid 'some_id_that_is_not_relevant'"