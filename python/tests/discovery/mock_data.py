
from openral_py.repository import MockRalObjectRepository, RalObjectRepository


class MockDataRemote: 
    """
    Some Mock Data for a remote RAL repository.

    Hiearchy:
    - farm_id
        - me_pc
            - mqtt_id
                - mqtt_child
            - firebaseConnectionUID
    """

    docs_by_uid = {
        "farm_id": {
        "identity": {
            "UID": "farm_id",
            "name": "Farm Instance",
            "siteTag": "PER",
        },
        "definition": {
            "definitionText": "This is a farm",
            "definitionURL": "",
        },
        "objectState": "undefined",
        "template": {
            "RALType": "farm",
            "version": "1",
            "objectStateTemplates": [""],
        },
        "specificProperties": [
            {"key": "lastUpdateTimestamp", "value": "value", "unit": "timestamp"},
            {"key": "ipAddress", "value": "[add IP address here]", "unit": "string"},
            {"key": "port", "value": "[add port here]", "unit": "string"}
        ],
        "currentGeolocation": {
            #farm has no container id
        },
        "locationHistoryRef": [],
        "ownerHistoryRef": [],
        "methodHistoryRef": [],
        "linkedObjectRef": []
        },
        "me_pc": {
        "identity": {
            "UID": "me_pc",
            "name": "PC instance",
            "siteTag": "PER",
        },
        "definition": {
            "definitionText": "Is a software that serves MQTT messages.",
            "definitionURL": "",
        },
        "objectState": "undefined",
        "template": {
            "RALType": "pc_instance",
            "version": "1",
            "objectStateTemplates": [""],
        },
        "specificProperties": [
            {"key": "lastUpdateTimestamp", "value": "value", "unit": "timestamp"},
            {"key": "ipAddress", "value": "[add IP address here]", "unit": "string"},
            {"key": "port", "value": "[add port here]", "unit": "string"}
        ],
        "currentGeolocation": {
            "container": {"UID": "farm_id"} #me_pc is the root node of the discovery tree
        },
        "locationHistoryRef": [],
        "ownerHistoryRef": [],
        "methodHistoryRef": [],
        "linkedObjectRef": []
        },
        "mqtt_id": {
        "identity": {
            "UID": "mqtt_id",
            "name": "MQTT Broker megabrain permabot pt1",
            "siteTag": "PER",
        },
        "definition": {
            "definitionText": "Is a software that serves MQTT messages.",
            "definitionURL": "",
        },
        "objectState": "undefined",
        "template": {
            "RALType": "mqtt_broker_service", 
            "version": "1", 
            "objectStateTemplates": [""],
        },
        "specificProperties": [
            {"key": "lastUpdateTimestamp", "value": "value", "unit": "timestamp"},
            {"key": "ipAddress", "value": "[add IP address here]", "unit": "string"},
            {"key": "port", "value": "[add port here]", "unit": "string"}
        ],
        "currentGeolocation": {
            "container": {"UID": "me_pc"} #is a child of the PC instance
        },
        "locationHistoryRef": [],
        "ownerHistoryRef": [],
        "methodHistoryRef": [],
        "linkedObjectRef": []
        },
        "mqtt_child": {
        "identity": {
            "UID": "mqtt_child",
            "name": "Some child of the MQTT Broker",
            "siteTag": "PER",
        },
        "definition": {
            "definitionText": "A mock child of an MQTT Broker, for testing purposes.",
            "definitionURL": "",
        },
        "objectState": "undefined",
        "template": {
            "RALType": "xyz",
            "version": "1", 
            "objectStateTemplates": [""]
        },
        "specificProperties": [],
        "currentGeolocation": {
            "container": {"UID": "mqtt_id"} #is a child of the MQTT Broker
        },
        "locationHistoryRef": [],
        "ownerHistoryRef": [],
        "methodHistoryRef": [],
        "linkedObjectRef": []
        },
        "firebaseConnectionUID": {
        "identity": {
            "UID": "firebaseConnectionUID",
            "name": "Prototyp permabot firebase connector",
            "siteTag": "",
            "alternateIDs": [],
            "alternateNames": [],
        },
        "currentOwners": [],
        "definition": {
            "definitionText": "Contains all information to connect to a firebase cloud instance",
            "definitionURL": "",
        },
        "objectState": "undefined",
        "template": {
            "RALType": "firebaseConnector", 
            "version": "1", 
            "objectStateTemplates": [""]
        },
        "specificProperties": [
            {"key": "appId", "value": "myAppId", "unit": "String"},
            {"key": "apiKey", "value": "myApiKey", "unit": "String"},
            {"key": "projectId", "value": "myProjectId", "unit": "String"},
            {"key": "messagingSenderId", "value": "myMessagingSenderId", "unit": "String"},
            {"key": "messagingSenderId", "value": "myMessagingSenderId", "unit": "authDomain"}
        ],
        "currentGeolocation": {
            "container": {
            "UID": "me_pc", #is a child of the PC instance
            },
        },
        "locationHistoryRef": [],
        "ownerHistoryRef": [],
        "methodHistoryRef": [],
        "linkedObjectRef": []
        }
    }

    docs_by_container_id = {
        "farm_id": ["me_pc"],
        "me_pc": ["mqtt_id", "firebaseConnectionUID"],
        "mqtt_id": ["mqtt_child"],
    }

    @staticmethod
    def getMockRalRepository() -> RalObjectRepository:
        return MockRalObjectRepository(
            docs_by_uid= MockDataRemote.docs_by_uid,
            docs_by_container_id= MockDataRemote.docs_by_container_id,
        )
    

class MockDataLocal:
    """
    Some Mock Data for a local RAL repository.

    Hiearchy:
    - me_pc
        - mqtt_id
            - mqtt_child
        - firebaseConnectionUID
    """

    docs_by_uid = {
        "me_pc": {
        "identity": {
            "UID": "me_pc",
            "name": "PC instance",
            "siteTag": "PER",
        },
        "definition": {
            "definitionText": "Is a software that serves MQTT messages.",
            "definitionURL": "",
        },
        "objectState": "undefined",
        "template": {
            "RALType": "pc_instance",
            "version": "1",
            "objectStateTemplates": [""],
        },
        "specificProperties": [
            {"key": "lastUpdateTimestamp", "value": "value", "unit": "timestamp"},
            {"key": "ipAddress", "value": "[add IP address here]", "unit": "string"},
            {"key": "port", "value": "[add port here]", "unit": "string"}
        ],
        "currentGeolocation": {
            "container": {"UID": "some_id_that_is_not_relevant"} #me_pc is the root node of the discovery tree
        },
        "locationHistoryRef": [],
        "ownerHistoryRef": [],
        "methodHistoryRef": [],
        "linkedObjectRef": []
        },
        "mqtt_id": {
        "identity": {
            "UID": "mqtt_id",
            "name": "MQTT Broker megabrain permabot pt1",
            "siteTag": "PER",
        },
        "definition": {
            "definitionText": "Is a software that serves MQTT messages.",
            "definitionURL": "",
        },
        "objectState": "undefined",
        "template": {
            "RALType": "mqtt_broker_service", 
            "version": "1", 
            "objectStateTemplates": [""]
        },
        "specificProperties": [
            {"key": "lastUpdateTimestamp", "value": "value", "unit": "timestamp"},
            {"key": "ipAddress", "value": "[add IP address here]", "unit": "string"},
            {"key": "port", "value": "[add port here]", "unit": "string"}
        ],
        "currentGeolocation": {
            "container": {"UID": "me_pc"} #is a child of the PC instance
        },
        "locationHistoryRef": [],
        "ownerHistoryRef": [],
        "methodHistoryRef": [],
        "linkedObjectRef": []
        },
        "mqtt_child": {
        "identity": {
            "UID": "mqtt_child",
            "name": "Some child of the MQTT Broker",
            "siteTag": "PER",
        },
        "definition": {
            "definitionText": "A mock child of an MQTT Broker, for testing purposes.",
            "definitionURL": "",
        },
        "objectState": "undefined",
        "template": {
            "RALType": "xyz", 
            "version": "1", 
            "objectStateTemplates": [""]
        },
        "specificProperties": [],
        "currentGeolocation": {
            "container": {"UID": "mqtt_id"} #is a child of the MQTT Broker
        },
        "locationHistoryRef": [],
        "ownerHistoryRef": [],
        "methodHistoryRef": [],
        "linkedObjectRef": []
        },
        "firebaseConnectionUID": {
        "identity": {
            "UID": "firebaseConnectionUID",
            "name": "Prototyp permabot firebase connector",
            "siteTag": "",
            "alternateIDs": [],
            "alternateNames": [],
        },
        "currentOwners": [],
        "definition": {
            "definitionText": "Contains all information to connect to a firebase cloud instance",
            "definitionURL": "",
        },
        "objectState": "undefined",
        "template": {
            "RALType": "firebaseConnector", 
            "version": "1", 
            "objectStateTemplates": [""]
        },
        "specificProperties": [
            {"key": "appId", "value": "myAppId", "unit": "String"},
            {"key": "apiKey", "value": "myApiKey", "unit": "String"},
            {"key": "projectId", "value": "myProjectId", "unit": "String"},
            {"key": "messagingSenderId", "value": "myMessagingSenderId", "unit": "String"},
            {"key": "messagingSenderId", "value": "myMessagingSenderId", "unit": "authDomain"}
        ],
        "currentGeolocation": {
            "container": {
            "UID": "me_pc", #is a child of the PC instance
            },
        },
        "locationHistoryRef": [],
        "ownerHistoryRef": [],
        "methodHistoryRef": [],
        "linkedObjectRef": []
        }
    }

    docs_by_container_id = {
        "some_id_that_is_not_relevant": ["me_pc"],
        "me_pc": ["mqtt_id", "firebaseConnectionUID"],
        "mqtt_id": ["mqtt_child"],
    }

    @staticmethod
    def  getMockRalRepository() -> RalObjectRepository: 
        return MockRalObjectRepository(
            docs_by_uid = MockDataLocal.docs_by_uid,
            docs_by_container_id = MockDataLocal.docs_by_container_id,
        )
  
