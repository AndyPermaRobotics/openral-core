import { expect } from 'chai';
import 'mocha';

import { RalMethod } from '../src/model/ral_method';


describe('RalMethod', () => {
    describe('.fromMap', () => {
        it('should return a RalMethod', () => {
            let data = {
                "definition": {
                    "definitionText": "",
                    "definitionURL": ""
                },
                "existenceStarts": null,
                "duration": null,
                "identity": {
                    "UID": "myUID",
                    "name": "",
                    "siteTag": "",
                    "alternateIDs": [],
                    "alternateNames": []
                },
                "methodState": "undefined",
                "template": {
                    "RALType": "myMethodTemplate",
                    "version": "1",
                    "methodStateTemplates": "generalMethodState"
                },
                "specificProperties": [
                    {
                        "key": "myKey",
                        "value": "myValue",
                        "unit": "myUnit"
                    }
                ],
                "inputObjects": [
                    {
                        "role": "specialRoleForMethod", //the role is important for the inputObjects of a RalMethod
                        "identity": {
                            "UID": "myNestedInputUid",
                            "name": "thing",
                            "siteTag": "",
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
                            "objectStateTemplates": ["generalObjectState"]
                        },
                        "specificProperties": [
                            {
                                "key": "serial number",
                                "value": "",
                                "unit": "String"
                            }
                        ],
                        "currentGeolocation": {
                            "container": {
                                "UID": "unknown"
                            },
                            "postalAddress": {
                                "country": "unknown",
                                "cityName": "unknown",
                                "cityNumber": "unknown",
                                "streetName": "unknown",
                                "streetNumber": "unknown"
                            },
                            "3WordCode": "unknown",
                            "geoCoordinates": {
                                "longitude": 0,
                                "latitude": 0
                            },
                            "plusCode": "unknown"
                        },
                        "locationHistoryRef": [],
                        "ownerHistoryRef": [],
                        "methodHistoryRef": [],
                        "linkedObjectRef": []
                    }
                ],
                "inputObjectsRef": [
                    {
                        "UID": "inputRefUID",
                        "role": "myRole"
                    },

                ],
                "outputObjects": [
                    {
                        "identity": {
                            "UID": "myNestedOutputUid",
                            "name": "thing",
                            "siteTag": "",
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
                            "objectStateTemplates": ["generalObjectState"]
                        },
                        "specificProperties": [
                            {
                                "key": "serial number",
                                "value": "",
                                "unit": "String"
                            }
                        ],
                        "currentGeolocation": {
                            "container": {
                                "UID": "unknown"
                            },
                            "postalAddress": {
                                "country": "unknown",
                                "cityName": "unknown",
                                "cityNumber": "unknown",
                                "streetName": "unknown",
                                "streetNumber": "unknown"
                            },
                            "3WordCode": "unknown",
                            "geoCoordinates": {
                                "longitude": 0,
                                "latitude": 0
                            },
                            "plusCode": "unknown"
                        },
                        "locationHistoryRef": [],
                        "ownerHistoryRef": [],
                        "methodHistoryRef": [],
                        "linkedObjectRef": []
                    }
                ],
                "outputObjectsRef": [
                    {
                        "UID": "outputRefUID",
                        "role": "myRole"
                    }
                ],
                "nestedMethods": [
                    {
                        "definition": {
                            "definitionText": "",
                            "definitionURL": ""
                        },
                        "existenceStarts": null,
                        "duration": null,
                        "identity": {
                            "UID": "myNestedUid",
                            "name": "",
                            "siteTag": "",
                            "alternateIDs": [],
                            "alternateNames": []
                        },
                        "methodState": "undefined",
                        "template": {
                            "RALType": "myMethodTemplate",
                            "version": "1",
                            "methodStateTemplates": "generalMethodState"
                        },
                        "specificProperties": [
                            {
                                "key": "myKey",
                                "value": "myValue",
                                "unit": "myUnit"
                            }
                        ],
                        "inputObjects": [],
                        "inputObjectsRef": [
                            {
                                "UID": "inputRefUID",
                                "role": "myRole"
                            },

                        ],
                        "outputObjects": [],
                        "outputObjectsRef": [
                            {
                                "UID": "outputRefUID",
                                "role": "myRole"
                            }
                        ],
                        "nestedMethods": []
                    }
                ]
            }

            let ralMethod = RalMethod.fromMap(data);

            expect(ralMethod).to.be.instanceOf(RalMethod);

            expect(ralMethod.identity.uid).to.equal("myUID", "identity.UID");
            expect(ralMethod.template.ralType).to.equal("myMethodTemplate", "template.RALType");

            expect(ralMethod.methodState).to.equal("undefined", "methodState should be 'undefined'");

            expect(ralMethod.specificProperties.count).to.equal(1, "specificProperties length");

            expect(ralMethod.specificProperties.getValueOf("myKey")).to.equal("myValue", "specificProperties value");
            expect(ralMethod.specificProperties.getProperty("myKey")!.unit).to.equal("myUnit", "specificProperties unit");

            //nested methods
            expect(ralMethod.nestedMethods.length).to.equal(1, "nestedMethods length");
            expect(ralMethod.nestedMethods[0].identity.uid).to.equal("myNestedUid", "nestedMethods[0].identity.UID");

            //inputObjects
            expect(ralMethod.inputObjects.length).to.equal(1, "inputObjects length");
            expect(ralMethod.inputObjects[0].role).to.equal("specialRoleForMethod", "inputObjects[0].role");
            expect(ralMethod.inputObjects[0].identity.uid).to.equal("myNestedInputUid", "inputObjects[0].identity.UID");

            //outputObjects
            expect(ralMethod.outputObjects.length).to.equal(1, "outputObjects length");
            expect(ralMethod.outputObjects[0].identity.uid).to.equal("myNestedOutputUid", "outputObjects[0].identity.UID");

            //inputObjectsRef
            expect(ralMethod.inputObjectsRef.length).to.equal(1, "inputObjectsRef length");
            expect(ralMethod.inputObjectsRef[0].uid).to.equal("inputRefUID", "inputObjectsRef[0].UID");

            //outputObjectsRef
            expect(ralMethod.outputObjectsRef.length).to.equal(1, "outputObjectsRef length");
            expect(ralMethod.outputObjectsRef[0].uid).to.equal("outputRefUID", "outputObjectsRef[0].UID");

        });
    });

    describe('.toMap', () => {
        it('should return a Record<string, any> with all properties', () => {
            let data = {
                "definition": {
                    "definitionText": "",
                    "definitionURL": ""
                },
                "existenceStarts": null,
                "duration": null,
                "identity": {
                    "UID": "myUID",
                    "name": "",
                    "siteTag": "",
                    "alternateIDs": [],
                    "alternateNames": []
                },
                "methodState": "undefined",
                "template": {
                    "RALType": "myMethodTemplate",
                    "version": "1",
                    "methodStateTemplates": "generalMethodState"
                },
                "specificProperties": [
                    {
                        "key": "myKey",
                        "value": "myValue",
                        "unit": "myUnit"
                    }
                ],
                "inputObjects": [
                    {
                        "role": "specialRoleForMethod", //the role is important for the inputObjects of a RalMethod
                        "identity": {
                            "UID": "myNestedInputUid",
                            "name": "thing",
                            "siteTag": "",
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
                            "objectStateTemplates": ["generalObjectState"]
                        },
                        "specificProperties": [
                            {
                                "key": "serial number",
                                "value": "",
                                "unit": "String"
                            }
                        ],
                        "currentGeolocation": {
                            "container": {
                                "UID": "unknown"
                            },
                            "postalAddress": {
                                "country": "unknown",
                                "cityName": "unknown",
                                "cityNumber": "unknown",
                                "streetName": "unknown",
                                "streetNumber": "unknown"
                            },
                            "3WordCode": "unknown",
                            "geoCoordinates": {
                                "longitude": 0,
                                "latitude": 0
                            },
                            "plusCode": "unknown"
                        },
                        "locationHistoryRef": [],
                        "ownerHistoryRef": [],
                        "methodHistoryRef": [],
                        "linkedObjectRef": []
                    }
                ],
                "inputObjectsRef": [
                    {
                        "UID": "inputRefUID",
                        "role": "myRole"
                    },

                ],
                "outputObjects": [
                    {
                        "identity": {
                            "UID": "myNestedOutputUid",
                            "name": "thing",
                            "siteTag": "",
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
                            "objectStateTemplates": ["generalObjectState"]
                        },
                        "specificProperties": [
                            {
                                "key": "serial number",
                                "value": "",
                                "unit": "String"
                            }
                        ],
                        "currentGeolocation": {
                            "container": {
                                "UID": "unknown"
                            },
                            "postalAddress": {
                                "country": "unknown",
                                "cityName": "unknown",
                                "cityNumber": "unknown",
                                "streetName": "unknown",
                                "streetNumber": "unknown"
                            },
                            "3WordCode": "unknown",
                            "geoCoordinates": {
                                "longitude": 0,
                                "latitude": 0
                            },
                            "plusCode": "unknown"
                        },
                        "locationHistoryRef": [],
                        "ownerHistoryRef": [],
                        "methodHistoryRef": [],
                        "linkedObjectRef": []
                    }
                ],
                "outputObjectsRef": [
                    {
                        "UID": "outputRefUID",
                        "role": "myRole"
                    }
                ],
                "nestedMethods": [
                    {
                        "definition": {
                            "definitionText": "",
                            "definitionURL": ""
                        },
                        "existenceStarts": null,
                        "duration": null,
                        "identity": {
                            "UID": "myNestedUid",
                            "name": "",
                            "siteTag": "",
                            "alternateIDs": [],
                            "alternateNames": []
                        },
                        "methodState": "undefined",
                        "template": {
                            "RALType": "myMethodTemplate",
                            "version": "1",
                            "methodStateTemplates": "generalMethodState"
                        },
                        "specificProperties": [
                            {
                                "key": "myKey",
                                "value": "myValue",
                                "unit": "myUnit"
                            }
                        ],
                        "inputObjects": [],
                        "inputObjectsRef": [
                            {
                                "UID": "inputRefUID",
                                "role": "myRole"
                            },

                        ],
                        "outputObjects": [],
                        "outputObjectsRef": [
                            {
                                "UID": "outputRefUID",
                                "role": "myRole"
                            }
                        ],
                        "nestedMethods": []
                    }
                ]
            }

            let ralMethod = RalMethod.fromMap(data);

            let map = ralMethod.toMap();

            expect(map["identity"]["UID"]).to.equal("myUID", "identity.UID");

            expect(map["template"]["RALType"]).to.equal("myMethodTemplate", "template.RALType");

            expect(map["methodState"]).to.equal("undefined", "methodState should be 'undefined'");

            expect(map["specificProperties"].length).to.equal(1, "specificProperties length");

            expect(map["specificProperties"][0]["key"]).to.equal("myKey", "specificProperties key");
            expect(map["specificProperties"][0]["value"]).to.equal("myValue", "specificProperties value");
            expect(map["specificProperties"][0]["unit"]).to.equal("myUnit", "specificProperties unit");

            //nested methods
            expect(map["nestedMethods"].length).to.equal(1, "nestedMethods length");
            expect(map["nestedMethods"][0]["identity"]["UID"]).to.equal("myNestedUid", "nestedMethods[0].identity.UID");

            //inputObjects
            expect(map["inputObjects"].length).to.equal(1, "inputObjects length");
            expect(map["inputObjects"][0]["role"]).to.equal("specialRoleForMethod", "inputObjects[0].role");
            expect(map["inputObjects"][0]["identity"]["UID"]).to.equal("myNestedInputUid", "inputObjects[0].identity.UID");

            //outputObjects
            expect(map["outputObjects"].length).to.equal(1, "outputObjects length");
            expect(map["outputObjects"][0]["identity"]["UID"]).to.equal("myNestedOutputUid", "outputObjects[0].identity.UID");

            //inputObjectsRef
            expect(map["inputObjectsRef"].length).to.equal(1, "inputObjectsRef length");
            expect(map["inputObjectsRef"][0]["UID"]).to.equal("inputRefUID", "inputObjectsRef[0].UID");

            //outputObjectsRef
            expect(map["outputObjectsRef"].length).to.equal(1, "outputObjectsRef length");
            expect(map["outputObjectsRef"][0]["UID"]).to.equal("outputRefUID", "outputObjectsRef[0].UID");


        });
    });
});