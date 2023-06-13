import { CurrentGeoLocation } from "./current_geo_location";
import { Definition } from "./definition";
import { Identity } from "./identity";
import { SpecificProperties } from "./specific_properties";
import { SpecificProperty } from "./specific_property";
import { Template } from "./template";


export { CurrentGeoLocation, Definition, Identity, SpecificProperties, Template, SpecificProperty };

export class RalObject {
    public identity: Identity;
    public currentOwners: string[];
    public definition: Definition;
    public objectState: string;
    public template: Template;
    public specificProperties: SpecificProperties;
    public currentGeoLocation: CurrentGeoLocation;
    public locationHistoryRef: string[];
    public ownerHistoryRef: string[];
    public methodHistoryRef: string[];
    public linkedObjectRef: string[];

    constructor(
        params: {
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
    }
    ) {
        this.identity = params.identity;
        this.currentOwners = params.currentOwners || [];
        this.definition = params.definition;
        this.objectState = params.objectState || "undefined";
        this.template = params.template;
        this.specificProperties = params.specificProperties;
        this.currentGeoLocation = params.currentGeoLocation;
        this.locationHistoryRef = params.locationHistoryRef || [];
        this.ownerHistoryRef = params.ownerHistoryRef || [];
        this.methodHistoryRef = params.methodHistoryRef || [];
        this.linkedObjectRef = params.linkedObjectRef || [];
    }

    transformTo(specificPropertiesTransform: (specificProperties: SpecificProperties) => SpecificProperties): RalObject {
        return new RalObject({
            identity: this.identity,
            definition: this.definition,
            template: this.template,
            specificProperties: specificPropertiesTransform(this.specificProperties),
            currentGeoLocation: this.currentGeoLocation,
            currentOwners: this.currentOwners,
            objectState: this.objectState,
            locationHistoryRef: this.locationHistoryRef,
            ownerHistoryRef: this.ownerHistoryRef,
            methodHistoryRef: this.methodHistoryRef,
            linkedObjectRef: this.linkedObjectRef
        });
    }

    toMap(): Record<string, any> {
        return {
            identity: this.identity.toMap(),
            currentOwners: this.currentOwners,
            definition: this.definition.toMap(),
            objectState: this.objectState,
            template: this.template.toMap(),
            specificProperties: this.specificProperties.toMaps(),
            currentGeoLocation: this.currentGeoLocation.toMap(),
            locationHistoryRef: this.locationHistoryRef,
            ownerHistoryRef: this.ownerHistoryRef,
            methodHistoryRef: this.methodHistoryRef,
            linkedObjectRef: this.linkedObjectRef,
        };
    }

    static fromMap(map: Record<string, any>): RalObject {
        const identity: Identity = Identity.fromMap(map.identity);
        const currentOwners: string[] = map.currentOwners || [];
        const definition: Definition = Definition.fromMap(map.definition);
        const objectState: string = map.objectState || "undefined";
        const template: Template = Template.fromMap(map.template);
        const specificProperties: SpecificProperties = SpecificProperties.fromMaps(map.specificProperties);
        const currentGeoLocation: CurrentGeoLocation = CurrentGeoLocation.fromMap(map.currentGeoLocation);
        const locationHistoryRef: string[] = map.locationHistoryRef || [];
        const ownerHistoryRef: string[] = map.ownerHistoryRef || [];
        const methodHistoryRef: string[] = map.methodHistoryRef || [];
        const linkedObjectRef: string[] = map.linkedObjectRef || [];

        return new RalObject({
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
    }
}
