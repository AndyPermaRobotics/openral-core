

from openral_py.ral_object import RalObject


class TestRalObject:
    
    def test_from_map(self):
        #Arrange
        data = {
            "identity": {
                "UID": "uid",
                "name": "thing",
                "siteTag": "siteTag",
                "alternateIDs": [],
                "alternateNames": []
            },
            "currentOwners": [],
            "definition": {
                "definitionText": "An object or entity that is not or cannot be named specifically",
                "definitionURL": "https://www.thefreedictionary.com/thing"
            },
            "objectState": "undefined",
            "template": {
                "RALType": "thing",
                "version": "1",
                "objectStateTemplates": "generalObjectState"
            },
            "specificProperties": [
                {
                "key": "serial number",
                "value": "my_value",
                "unit": "String"
                }
            ],
            "currentGeolocation": {
                "container": {
                "UID": "unknown"
                },
                # todo
                # "postalAddress": {
                # "country": "unknown",
                # "cityName": "unknown",
                # "cityNumber": "unknown",
                # "streetName": "unknown",
                # "streetNumber": "unknown"
                # },
                # "3WordCode": "unknown",
                # "geoCoordinates": {
                # "longitude": 0,
                # "latitude": 0
                # },
                # "plusCode": "unknown"
            },
            "locationHistoryRef": [],
            "ownerHistoryRef": [],
            "methodHistoryRef": [],
            "linkedObjectRef": []
        }

        #Act
        ral_object = RalObject.from_map(data)

        #Assert
        assert ral_object.identity.uid == "uid"
        assert ral_object.identity.name == "thing"
        assert ral_object.identity.site_tag == "siteTag"
        assert ral_object.identity.alternate_ids == []
        assert ral_object.identity.alternate_names == []

        assert ral_object.current_owners == []

        assert ral_object.definition.definition_text == "An object or entity that is not or cannot be named specifically"
        assert ral_object.definition.definition_url == "https://www.thefreedictionary.com/thing"

        assert ral_object.object_state == "undefined"

        assert ral_object.template.ral_type == "thing"
        assert ral_object.template.version == "1"
        assert ral_object.template.object_state_templates == "generalObjectState"


        specific_properties = ral_object.specific_properties.get("serial number")
        if specific_properties is not None:
            assert specific_properties.key == "serial number"
            assert specific_properties.value == "my_value"
            assert specific_properties.unit == "String"
        else:
            assert False, "specific_properties is None"

        container = ral_object.current_geo_location.container
        if container is not None:
            assert container.uid == "unknown"
        else:
            assert False, "container is None"

        # todo
        # assert ral_object.current_geolocation.postal_address.country == "unknown"
        # assert ral_object.current_geolocation.postal_address.city_name == "unknown"
        # assert ral_object.current_geolocation.postal_address.city_number == "unknown"
        # assert ral_object.current_geolocation.postal_address.street_name == "unknown"
        # assert ral_object.current_geolocation.postal_address.street_number == "unknown"

        assert ral_object.location_history_ref == []
        assert ral_object.owner_history_ref == []
        assert ral_object.method_ristory_ref == []
        assert ral_object.linked_object_ref == []
    
    
    def test_from_map_minimum_data(self):
        #Arrange
        data = {
            "identity": {
                "UID": "uid",
            },
            "definition": {
                
            },
            
            "template": {
                "RALType": "thing",
                "version": "1",
                "objectStateTemplates": "generalObjectState"
            },
            "specificProperties": [],
            "currentGeolocation": {
                
                # todo
                # "postalAddress": {
                # "country": "unknown",
                # "cityName": "unknown",
                # "cityNumber": "unknown",
                # "streetName": "unknown",
                # "streetNumber": "unknown"
                # },
                # "3WordCode": "unknown",
                # "geoCoordinates": {
                # "longitude": 0,
                # "latitude": 0
                # },
                # "plusCode": "unknown"
            },
        }

        #Act
        ral_object = RalObject.from_map(data)

        #Assert
        assert ral_object.identity.uid == "uid"
        assert ral_object.identity.name is None
        assert ral_object.identity.site_tag is None
        assert ral_object.identity.alternate_ids == []
        assert ral_object.identity.alternate_names == []

        assert ral_object.current_owners == []

        assert ral_object.definition.definition_text is None
        assert ral_object.definition.definition_url is None

        assert ral_object.object_state == "undefined", "object_state default value is undefined"

        assert ral_object.template.ral_type == "thing"
        assert ral_object.template.version == "1"
        assert ral_object.template.object_state_templates == "generalObjectState"


        assert len(ral_object.specific_properties.map) == 0, "specific_properties is empty"

        container = ral_object.current_geo_location.container
        assert container is None, "container is None"

        # todo
        # assert ral_object.current_geolocation.postal_address.country == "unknown"
        # assert ral_object.current_geolocation.postal_address.city_name == "unknown"
        # assert ral_object.current_geolocation.postal_address.city_number == "unknown"
        # assert ral_object.current_geolocation.postal_address.street_name == "unknown"
        # assert ral_object.current_geolocation.postal_address.street_number == "unknown"

        assert ral_object.location_history_ref == [], "locationHistoryRef is empty list"
        assert ral_object.owner_history_ref == [], "ownerHistoryRef is empty list"
        assert ral_object.method_ristory_ref == [], "methodHistoryRef is empty list"
        assert ral_object.linked_object_ref == [], "linkedObjectRef is empty list"
    