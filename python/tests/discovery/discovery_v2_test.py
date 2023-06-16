
import pytest
from openral_py.discovery.discovery_v2 import DiscoveryV2
from openral_py.discovery.model.discovery_dimension import DiscoveryDimension
from tests.discovery.mock_data_discovery_v2 import MockDataDiscoveryV2


class TestDiscovery:
    

    @pytest.mark.asyncio
    async def test_discovery(self):
        """
        Tests the discovery algorithm with a mock repository.
        """

        # Arrange
        ral_repository = MockDataDiscoveryV2.getMockRalRepository()

        # Act
        discovery = DiscoveryV2(
            ral_repository= ral_repository,
            start_object= await ral_repository.get_by_uid("Start"),
            root_node_ral_type= "wurzel_type", #we want to find the root node of the tree that has this ral type
            primary_discovery_dimension = DiscoveryDimension.containerId,
            discovery_dimensions = [DiscoveryDimension.containerId,DiscoveryDimension.owner]
        )

        result = await discovery.execute()

        # Assert
        assert result.data.template.ral_type == "wurzel_type", "The root node should have the ral type 'wurzel_type'"
        assert result.data.identity.uid == "wurzel", "The root node should have the uid 'wurzel'"

        # Check root node
        assert len(result.children(DiscoveryDimension.containerId)) == 2, "The root node should have 2 children with dimension 'containerId'"
        assert len(result.children(DiscoveryDimension.owner)) == 0, "The root node should have 0 children with dimension 'owner'"

        assert [value.data.identity.uid for value in result.children(DiscoveryDimension.containerId)] == ["A","B"], "The root node should have 2 children with dimension 'containerId'"

