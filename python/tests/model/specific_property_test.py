from typing import Any, Dict

import pytest

from openral_py.model.specific_property import SpecificProperty


class TestSpecificPropertyFromMap:
    @pytest.fixture
    def property_map(self) -> Dict[str, Any]:
        return {
            'key': 'length',
            'value': '10',
            'unit': 'm'
        }

    def test_from_map_returns_specific_property_instance(self, property_map):
        # arrange
        expected_key = 'length'
        expected_value = '10'
        expected_unit = 'm'

        # act
        result = SpecificProperty.from_map(property_map)

        # assert
        assert isinstance(result, SpecificProperty)
        assert result.key == expected_key
        assert result.value == expected_value
        assert result.unit == expected_unit

    def test_from_map_with_missing_unit_returns_specific_property_instance(self, property_map):
        # arrange
        del property_map['unit']
        expected_key = 'length'
        expected_value = '10'
        expected_unit = None

        # act
        result = SpecificProperty.from_map(property_map)

        # assert
        assert isinstance(result, SpecificProperty)
        assert result.key == expected_key
        assert result.value == expected_value
        assert result.unit == expected_unit

    def test_from_map_with_extra_fields_returns_specific_property_instance(self, property_map):
        # arrange
        property_map['extra'] = 'field'
        expected_key = 'length'
        expected_value = '10'
        expected_unit = 'm'

        # act
        result = SpecificProperty.from_map(property_map)

        # assert
        assert isinstance(result, SpecificProperty)
        assert result.key == expected_key
        assert result.value == expected_value
        assert result.unit == expected_unit
