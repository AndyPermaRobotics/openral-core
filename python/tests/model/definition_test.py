from openral_py.model.definition import Definition


class TestDefinition:

    def test_to_map_with_data(self):
        # Arrange
        definition_text = 'a test definition'
        definition_url = 'https://example.com'
        d = Definition(definition_text, definition_url)

        # Act
        result = d.to_map()

        # Assert
        assert result == {'definitionText': definition_text, 'definitionURL': definition_url}

    def test_to_map_without_data(self):
        # Arrange
        d = Definition()

        # Act
        result = d.to_map()

        # Assert
        assert result == {'definitionText': None, 'definitionURL': None}

    def test_from_map(self):
        # arrange
        input_data = {
            'definitionText': "A test definition",
            'definitionURL': "https://example.com"
        }
        
        # act
        output = Definition.from_map(input_data)
        
        # assert
        assert output.definition_text == "A test definition"
        assert output.definition_url == "https://example.com"

    def test_from_map_with_missing_data(self):
        # arrange
        input_data = {}
        
        # act
        output = Definition.from_map(input_data)
        
        # assert
        assert output.definition_text is None
        assert output.definition_url is None

    
