import { RalObject } from "model/ral_object";
import { CurrentGeoLocation } from "./current_geo_location";
import { Definition } from "./definition";
import { Identity } from "./identity";
import { SpecificProperties } from "./specific_properties";
import { SpecificProperty } from "./specific_property";
import { Template } from "./template";


export { CurrentGeoLocation, Definition, Identity, SpecificProperties, Template, SpecificProperty, RalObject };





///Extends the RalObject with a 'role' property
///thats needed for the inputObjects of a RalMethod, because each inputObject has a role inside the method
export class RalObjectWithRole extends RalObject {

    public role: string;

    constructor(
        role: string,
        identity: Identity,
        definition: Definition,
        template: Template,
        specificProperties: SpecificProperties,
        currentGeoLocation: CurrentGeoLocation,
        currentOwners?: string[],
        objectState?: string,
        locationHistoryRef?: string[],
        ownerHistoryRef?: string[],
        methodHistoryRef?: string[],
        linkedObjectRef?: string[],
    ) {
        super({
            identity: identity,
            definition: definition,
            template: template,
            specificProperties: specificProperties,
            currentGeoLocation: currentGeoLocation,
            currentOwners: currentOwners,
            objectState: objectState,
            locationHistoryRef: locationHistoryRef,
            ownerHistoryRef: ownerHistoryRef,
            methodHistoryRef: methodHistoryRef,
            linkedObjectRef: linkedObjectRef,
        });
        //this.identity = params.identity;
        this.role = role;
    }

    toMap(): Record<string, any> {
        let map = super.toMap();
        map["role"] = this.role;
        return map;
    }

    ///Creates a RalObjectWithRole from a RalObject and a role
    static fromRalObjectPlusRole(object: RalObject, role: string): RalObjectWithRole {

        return new RalObjectWithRole(
            role,
            object.identity,
            object.definition,
            object.template,
            object.specificProperties,
            object.currentGeoLocation,
            object.currentOwners,
            object.objectState,
            object.locationHistoryRef,
            object.ownerHistoryRef,
            object.methodHistoryRef,
            object.linkedObjectRef,
        )
    }

    static fromMap(map: Record<string, any>): RalObjectWithRole {
        const object = RalObject.fromMap(map);
        const role = map["role"];

        if (role == null) {
            throw new Error("role is not defined in the map");
        }
        else if (typeof role !== "string") {
            throw new Error("role is not a string");
        }
        else if (role.length == 0) {
            throw new Error("role is an empty string");
        }

        return RalObjectWithRole.fromRalObjectPlusRole(object, role);
    }
}

