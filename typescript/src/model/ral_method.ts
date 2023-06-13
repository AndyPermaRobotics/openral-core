import { Definition } from "model/definition";
import { Identity } from "model/identity";
import { ObjectRef } from "model/object_ref";
import { RalObject } from "model/ral_object";
import { RalObjectWithRole } from "model/ral_object_with_role";
import { SpecificProperties } from "model/specific_properties";
import { Template } from "model/template";


export class RalMethod {
    identity: Identity;
    definition: Definition;
    template: Template;
    methodState: string;
    specificProperties: SpecificProperties;
    //todo existenceStarts
    //todo duration
    inputObjects: RalObjectWithRole[];
    outputObjects: RalObject[];
    nestedMethods: RalMethod[];

    inputObjectsRef: ObjectRef[];
    outputObjectsRef: ObjectRef[];

    constructor(params: {
        identity: Identity,
        definition: Definition,
        template: Template,
        methodState: string,
        specificProperties: SpecificProperties,
        inputObjects: RalObjectWithRole[],
        outputObjects: RalObject[],
        nestedMethods: RalMethod[],
        inputObjectsRef: ObjectRef[],
        outputObjectsRef: ObjectRef[]
    }) {
        this.identity = params.identity;
        this.definition = params.definition;
        this.template = params.template;
        this.methodState = params.methodState;
        this.specificProperties = params.specificProperties;
        this.inputObjects = params.inputObjects;
        this.outputObjects = params.outputObjects;
        this.nestedMethods = params.nestedMethods;
        this.inputObjectsRef = params.inputObjectsRef;
        this.outputObjectsRef = params.outputObjectsRef;
    }

    toMap(): Record<string, any> {
        return {
            identity: this.identity.toMap(),
            definition: this.definition.toMap(),
            template: this.template.toMap(),
            methodState: this.methodState,
            specificProperties: this.specificProperties.toMaps(),
            inputObjects: this.inputObjects.map(inputObject => inputObject.toMap()),
            outputObjects: this.outputObjects.map(outputObject => outputObject.toMap()),
            nestedMethods: this.nestedMethods.map(nestedMethod => nestedMethod.toMap()),
            inputObjectsRef: this.inputObjectsRef.map(inputObjectRef => inputObjectRef.toMap()),
            outputObjectsRef: this.outputObjectsRef.map(outputObjectRef => outputObjectRef.toMap())
        }
    }

    static fromMap(map: Record<string, any>): RalMethod {
        const identity = Identity.fromMap(map.identity);
        const definition = Definition.fromMap(map.definition);
        const template = Template.fromMap(map.template);
        const methodState = map.methodState ?? "undefined";
        const specificProperties = SpecificProperties.fromMaps(map.specificProperties);

        let inputObjects: RalObjectWithRole[] = [];
        if (map.inputObjects != null) {
            inputObjects = map.inputObjects.map((inputObject: Record<string, any>) => RalObjectWithRole.fromMap(inputObject));
        }

        let outputObjects: RalObject[] = [];
        if (map.outputObjects != null) {
            outputObjects = map.outputObjects.map((outputObject: Record<string, any>) => RalObject.fromMap(outputObject));
        }

        let nestedMethods: RalMethod[] = [];
        if (map.nestedMethods != null) {
            nestedMethods = map.nestedMethods.map((nestedMethod: Record<string, any>) => RalMethod.fromMap(nestedMethod));
        }

        let inputObjectsRef: ObjectRef[] = [];
        if (map.inputObjectsRef != null) {
            inputObjectsRef = map.inputObjectsRef.map((inputObjectRef: Record<string, any>) => ObjectRef.fromMap(inputObjectRef));
        }

        let outputObjectsRef: ObjectRef[] = [];
        if (map.outputObjectsRef != null) {
            outputObjectsRef = map.outputObjectsRef.map((outputObjectRef: Record<string, any>) => ObjectRef.fromMap(outputObjectRef));
        }

        return new RalMethod({
            identity,
            definition,
            template,
            methodState,
            specificProperties,
            inputObjects,
            outputObjects,
            nestedMethods,
            inputObjectsRef,
            outputObjectsRef
        });
    }

}