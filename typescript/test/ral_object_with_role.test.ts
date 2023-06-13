import { expect } from 'chai';
import 'mocha';

import { Container } from '../src/model/container';
import { CurrentGeoLocation, Definition, Identity, RalObject, RalObjectWithRole, SpecificProperties, SpecificProperty, Template } from '../src/model/ral_object_with_role';


describe('RalObjectWithRole', () => {
    describe('.fromMap', () => {
        it('should return a RalObjectWithRole', () => {
            const data = {
                "role": "roleOfObject", //here we have the additional role property
                "identity": {
                    "UID": "myUID",
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
                    "objectStateTemplates": "generalObjectState"
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

            const object: RalObjectWithRole = RalObjectWithRole.fromMap(data);

            expect(object).to.be.instanceOf(RalObjectWithRole);

            expect(object.role).to.equal("roleOfObject", "role");
            expect((object as RalObject).identity.uid).to.equal("myUID", "identity.UID");
            expect((object as RalObject).template.ralType).to.equal("thing", "template.RALType");

        });


    });

    describe('.fromRalObjectPlusRole', () => {
        it('should return a RalObjectWithRole', () => {
            //Arrange
            const testObject: RalObject = new RalObject({
                identity: new Identity("myUID"),
                definition: new Definition(),
                template: new Template("ralType", "1.0", null),
                specificProperties: new SpecificProperties({
                    "myProperty": new SpecificProperty("key", "value"),
                }),
                currentGeoLocation: new CurrentGeoLocation(new Container("unknown")),
            });

            const role = "myTestRole"

            //Act
            const objectWithRole = RalObjectWithRole.fromRalObjectPlusRole(testObject, role);

            //Assert
            expect(objectWithRole).to.be.instanceOf(RalObjectWithRole);


            expect(objectWithRole.role).to.equal(role, "myTestRole");
            expect((objectWithRole as RalObject).identity.uid).to.equal("myUID", "identity.UID");

        })

    });
});