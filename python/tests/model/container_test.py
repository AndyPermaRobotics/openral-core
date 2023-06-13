
from openral_py.model.container import Container


class TestContainer:

    def test_from_map_with_data(self):
        # Arrange
        uid = 123 # this is a number, not a string!
        container = Container.from_map({'UID': uid})

        # Act
        result = container.to_map()

        # Assert
        assert container.uid == uid
        assert result == {'UID': uid}
