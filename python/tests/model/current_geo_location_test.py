import pytest

from openral_py.model.container import Container
from openral_py.model.current_geo_location import CurrentGeoLocation


class TestCurrentGeoLocation:

    def test_current_geo_location_from_map(self):
        # arrange
        data = {'container': {'UID': 'uid'}}
        
        # act
        result = CurrentGeoLocation.from_map(data)
        
        # assert
        assert isinstance(result, CurrentGeoLocation)
        assert isinstance(result.container, Container)
        assert result.container.uid == 'uid'

    def test_current_geo_location_from_map_with_empty_data(self):
        # arrange
        data = {}
        
        # act
        result = CurrentGeoLocation.from_map(data)
        
        # assert
        assert isinstance(result, CurrentGeoLocation)
        assert result.container is None