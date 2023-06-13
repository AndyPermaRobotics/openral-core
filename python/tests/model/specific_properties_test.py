from typing import Any, Dict, Optional

from openral_py.model.specific_properties import SpecificProperties
from openral_py.model.specific_property import SpecificProperty


class TestSpecificProperties:
    
    def test_from_map(self):
        # arrange
        data = [
            {
                'key': 'key1',
                'value': 'value1',
                'unit': 'unit1',
            },
            {
                'key': 'key2',
                'value': 'value2',
                #no unit here
            },
        ]
        
        # act
        result = SpecificProperties.from_maps(data)
        
        # assert
        assert isinstance(result, SpecificProperties)
        assert isinstance(result['key1'], str)
        assert result['key1'] == 'value1'
        assert isinstance(result['key2'], str)
        assert result['key2'] == 'value2'


    def test_to_maps(self):
        # arrange
        specific_properties = {
            'key1': SpecificProperty('key1', 'value1', 'unit1'),
            'key2': SpecificProperty('key2', 'value2', 'unit2'),
        }
        sp = SpecificProperties(specific_properties)
        
        # act
        result = sp.to_maps()
        
        # assert
        assert isinstance(result, list)  # check if result is a list
        assert len(result) == 2  # check if length of result is 2
        assert isinstance(result[0], dict)  # check if first element of result is a dictionary
        assert isinstance(result[1], dict)  # check if second element of result is a dictionary
        assert result[0]['key'] == 'key1'  # check if key of first element is 'key1'
        assert result[0]['value'] == 'value1'  # check if value of first element is 'value1'
        assert result[0]['unit'] == 'unit1'  # check if unit of first element is 'unit1'
        assert result[1]['key'] == 'key2'  # check if key of second element is 'key2'
        assert result[1]['value'] == 'value2'  # check if value of second element is 'value2'
        assert result[1]['unit'] == 'unit2'  # check if unit of second element is 'unit2'

    def test_contains_key(self):
        # Erstelle eine Instanz von SpecificProperties für den Test
        specific_props = SpecificProperties({
            'key1': SpecificProperty('key1','value1'),
            'key2': SpecificProperty('key2','value2')
        })

        # Überprüfe, ob die enthaltenen Schlüssel korrekt zurückgegeben werden
        assert specific_props.contains_key('key1') == True
        assert specific_props.contains_key('key2') == True
        assert specific_props.contains_key('nonexistent_prop') == False

        # Überprüfe, dass die Methode auch mit leeren Instanzen funktioniert
        empty_props = SpecificProperties({})
        assert empty_props.contains_key('any_key') == False
