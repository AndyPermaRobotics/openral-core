import 'package:openral_core/src/repository/mock_ral_object_repository.dart';
import 'package:openral_core/src/repository/ral_object_repository.dart';

class MockDataDiscoveryV2 {
  static final Map<String, Map<String, dynamic>> docsByUid = {
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
      "specificProperties": [],
      "currentGeolocation": {},
      "locationHistoryRef": [],
      "ownerHistoryRef": [],
      "methodHistoryRef": [],
      "linkedObjectRef": [
        {
          "UID": "F",
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
      "specificProperties": [],
      "currentGeolocation": {
        "container": {
          "UID": "wurzel",
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
          "UID": "F",
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
      "specificProperties": [],
      "currentGeolocation": {
        "container": {
          "UID": "wurzel",
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
      "specificProperties": [],
      "currentGeolocation": {
        "container": {
          "UID": "B",
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
      "specificProperties": [],
      "currentGeolocation": {
        "container": {
          "UID": "A",
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
      "specificProperties": [],
      "currentGeolocation": {
        "container": {
          "UID": "Start",
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
      "currentOwners": [
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
      "specificProperties": [],
      "currentGeolocation": {},
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
      "currentOwners": [
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
      "specificProperties": [],
      "currentGeolocation": {},
      "locationHistoryRef": [],
      "ownerHistoryRef": [],
      "methodHistoryRef": [],
      "linkedObjectRef": [
        {
          "UID": "wurzel",
          "role": "",
        },
      ]
    },
  };

  static final Map<String, List<String>> docsByContainerId = {
    "wurzel": ["A", "B"],
    "A": ["Start"],
    "Start": ["D"],
    "B": ["C"],
    "C": [],
    "D": [],
    "F": [],
  };

  static RalObjectRepository getMockRalRepository() {
    return MockRalObjectRepository(
      docsByUid: docsByUid,
      docsByContainerId: docsByContainerId,
    );
  }
}
