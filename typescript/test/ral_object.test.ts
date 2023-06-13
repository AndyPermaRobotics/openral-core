import { expect } from 'chai';
import 'mocha';


import { RalObject } from '../src/model/ral_object';
describe('RalObject', () => {
  describe('.fromMap', () => {
    it('should return a RalObject', () => {
      let data = {
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

      let ralObject = RalObject.fromMap(data);

      expect(ralObject).to.be.instanceOf(RalObject);

      expect(ralObject.identity.uid).to.equal("myUID", "identity.UID");
      expect(ralObject.template.ralType).to.equal("thing", "template.RALType");
    });

    it('should return a RalObject with default values', () => {
      let data = {
        "identity": {
          "UID": "myUID",
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
        },
      }

      let ralObject = RalObject.fromMap(data);

      expect(ralObject).to.be.instanceOf(RalObject);

      expect(ralObject.identity.uid).to.equal("myUID", "identity.UID");
      expect(ralObject.template.ralType).to.equal("thing", "template.RALType");

      expect(ralObject.identity.name).to.equal(null, "identity.name");
      expect(ralObject.identity.siteTag).to.equal(null, "identity.siteTag");
      expect(ralObject.identity.alternateIds).to.deep.equal([], "identity.alternateIDs");
      expect(ralObject.identity.alternateNames).to.deep.equal([], "identity.alternateNames");

      expect(ralObject.currentOwners).to.deep.equal([], "currentOwners");

      expect(ralObject.definition.definitionText).to.equal(null, "definition.definitionText");
      expect(ralObject.definition.definitionUrl).to.equal(null, "definition.definitionURL");

      expect(ralObject.objectState).to.equal("undefined", "objectState");

      expect(ralObject.template.version).to.equal("1", "template.version");
      expect(ralObject.template.objectStateTemplates).to.equal("generalObjectState", "template.objectStateTemplates");

      expect(ralObject.specificProperties.toMaps().length).to.deep.equal(0, "specificProperties length");

      expect(ralObject.currentGeoLocation.container).to.equal(null, "currentGeoLocation.container");

      expect(ralObject.locationHistoryRef).to.deep.equal([], "locationHistoryRef");
      expect(ralObject.ownerHistoryRef).to.deep.equal([], "ownerHistoryRef");
      expect(ralObject.methodHistoryRef).to.deep.equal([], "methodHistoryRef");
      expect(ralObject.linkedObjectRef).to.deep.equal([], "linkedObjectRef");
    });
  });
});