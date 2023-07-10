
from openral_py.repository.mock_ral_object_repository import \
    MockRalObjectRepository
from openral_py.repository.ral_object_repository import RalObjectRepository


class MockDataDiscoveryV2: 
    """
    Some Mock Data to test the Discovery algorithm

    Hierarchy of the RalObjects by container.UID:
    - wurzel
        - A
            - Start
                - D
        - B
            - C
                
            
    Hierarchy of the RalObjects by owner:  (F has two owners A and Start)      
    - A
        - F
    - Start
        - F
            - B

    Dependencies of the RalObjects by linkedObjectRef:
    wurzel <-> F (bidirectional)
    
    
    """

    docs_by_uid = {
        "wurzel": {
            "identity": {
                "UID": "wurzel",
                "name": "wurzel, having no parents by container.UID",
                "siteTag": "PER",
            },
            "currentOwners": [],
            "definition": {
                "definitionText": "",
                "definitionURL": "",
            },
            "objectState": "undefined",
            "template": {
                "RALType": "wurzel_type",
                "version": "1",
                "objectStateTemplates": [""],
            },
            "specificProperties": [
            ],
            "currentGeolocation": {
                #wurzel has no container id
            },
            "locationHistoryRef": [],
            "ownerHistoryRef": [],
            "methodHistoryRef": [],
            "linkedObjectRef": [
                {
                    "UID": "F", # <- F
                    "role": "",
                },
            ]
        },
        "A": {
            "identity": {
                "UID": "A",
                "name": "A",
                "siteTag": "PER",
            },
            "currentOwners": [],
            "definition": {
                "definitionText": "",
                "definitionURL": "",
            },
            "objectState": "undefined",
            "template": {
                "RALType": "",
                "version": "1",
                "objectStateTemplates": [""],
            },
            "specificProperties": [
            ],
            "currentGeolocation": {
                "container": {
                    "UID": "wurzel", # <- wurzel
                }
            },
            "locationHistoryRef": [],
            "ownerHistoryRef": [],
            "methodHistoryRef": [],
            "linkedObjectRef": []
        },
        "B": {
            "identity": {
                "UID": "B",
                "name": "B",
                "siteTag": "PER",
            },
            "currentOwners": [
                {
                    "UID": "F", # <- F is owner of B
                    "RALType": "",
                },
            ],
            "definition": {
                "definitionText": "",
                "definitionURL": "",
            },
            "objectState": "undefined",
            "template": {
                "RALType": "",
                "version": "1",
                "objectStateTemplates": [""],
            },
            "specificProperties": [
            ],
            "currentGeolocation": {
                "container": {
                    "UID": "wurzel", # <- wurzel
                }
            },
            "locationHistoryRef": [],
            "ownerHistoryRef": [],
            "methodHistoryRef": [],
            "linkedObjectRef": []
        },
        "C": {
            "identity": {
                "UID": "C",
                "name": "C",
                "siteTag": "PER",
            },
            "currentOwners": [],
            "definition": {
                "definitionText": "",
                "definitionURL": "",
            },
            "objectState": "undefined",
            "template": {
                "RALType": "",
                "version": "1",
                "objectStateTemplates": [""],
            },
            "specificProperties": [
            ],
            "currentGeolocation": {
                "container": {
                    "UID": "B", # <- B
                }
            },
            "locationHistoryRef": [],
            "ownerHistoryRef": [],
            "methodHistoryRef": [],
            "linkedObjectRef": []
        },
        "Start": {
            "identity": {
                "UID": "Start",
                "name": "Start",
                "siteTag": "PER",
            },
            "currentOwners": [],
            "definition": {
                "definitionText": "",
                "definitionURL": "",
            },
            "objectState": "undefined",
            "template": {
                "RALType": "",
                "version": "1",
                "objectStateTemplates": [""],
            },
            "specificProperties": [
            ],
            "currentGeolocation": {
                "container": {
                    "UID": "A", # <- A
                }
            },
            "locationHistoryRef": [],
            "ownerHistoryRef": [],
            "methodHistoryRef": [],
            "linkedObjectRef": []
        },
        "D": {
            "identity": {
                "UID": "D",
                "name": "D",
                "siteTag": "PER",
            },
            "currentOwners": [],
            "definition": {
                "definitionText": "",
                "definitionURL": "",
            },
            "objectState": "undefined",
            "template": {
                "RALType": "",
                "version": "1",
                "objectStateTemplates": [""],
            },
            "specificProperties": [
            ],
            "currentGeolocation": {
                "container": {
                    "UID": "Start", # <- Start
                }
            },
            "locationHistoryRef": [],
            "ownerHistoryRef": [],
            "methodHistoryRef": [],
            "linkedObjectRef": []
        },
        "E": {
            "identity": {
                "UID": "E",
                "name": "",
                "siteTag": "PER",
            },
            "currentOwners": [ # <- E has two owners D and C 
                {
                    "UID": "D",
                    "RALType": "",
                },
                {
                    "UID": "C",
                    "RALType": "",
                }
            ],
            "definition": {
                "definitionText": "",
                "definitionURL": "",
            },
            "objectState": "undefined",
            "template": {
                "RALType": "",
                "version": "1",
                "objectStateTemplates": [""],
            },
            "specificProperties": [
            ],
            "currentGeolocation": {
                #E has no container id
            },
            "locationHistoryRef": [],
            "ownerHistoryRef": [],
            "methodHistoryRef": [],
            "linkedObjectRef": []
        },
        "F": {
            "identity": {
                "UID": "F",
                "name": "",
                "siteTag": "PER",
            },
            "currentOwners": [ # <- F has two owners A and Start
                {
                    "UID": "A",
                    "RALType": "",
                },
                {
                    "UID": "Start",
                    "RALType": "",
                }
            ],
            "definition": {
                "definitionText": "",
                "definitionURL": "",
            },
            "objectState": "undefined",
            "template": {
                "RALType": "",
                "version": "1",
                "objectStateTemplates": [""],
            },
            "specificProperties": [
            ],
            "currentGeolocation": {
                #F has no container id
            },
            "locationHistoryRef": [],
            "ownerHistoryRef": [],
            "methodHistoryRef": [],
            "linkedObjectRef": [
                {
                    "UID": "wurzel", # <- wurzel
                    "role": "",
                },
            ]
        },
    }

    docs_by_container_id = {
        "wurzel": ["A", "B"],
        "A": ["Start"],
        "Start": ["D"],
        "B": ["C"],
        "C": [],
        "D": [],
        "F": [],
    }

    @staticmethod
    def getMockRalRepository() -> RalObjectRepository:
        return MockRalObjectRepository(
            docs_by_uid= MockDataDiscoveryV2.docs_by_uid,
            docs_by_container_id= MockDataDiscoveryV2.docs_by_container_id,
        )
    
