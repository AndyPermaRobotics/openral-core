
import { Container, CurrentGeoLocation, Definition, Identity, RalMethod, RalObject, RalObjectWithRole, SpecificProperties, SpecificProperty, Template } from 'openral-js';

//this is how to create a RalObject
let myRalObject: RalObject = new RalObject({
    identity: new Identity("myUid"),
    definition: new Definition("An Example RalObject"),
    template: new Template("exampleObject", "1.0", null),
    specificProperties: new SpecificProperties({
        "myPropertyKey": new SpecificProperty("myPropertyKey", "value"),
    }),
    currentGeoLocation: new CurrentGeoLocation(new Container("containerUid")),
});

console.log(myRalObject);


//we can use the ralObject as an Input Object for a RalMethod by adding a role and creating a RalObjectWithRole

const inputObject = RalObjectWithRole.fromRalObjectPlusRole(
    myRalObject, "roleOfRalObject")


const myRalmethod = new RalMethod(
    {
        identity: new Identity("methodUid"),
        definition: new Definition(),
        specificProperties: new SpecificProperties({}),
        template: new Template("methodeRalType", "1.0"),
        methodState: "undefined",
        inputObjects: [
            inputObject,
        ],
        outputObjects: [],
        nestedMethods: [],
        inputObjectsRef: [],
        outputObjectsRef: [],
    }
);

console.log(myRalmethod);