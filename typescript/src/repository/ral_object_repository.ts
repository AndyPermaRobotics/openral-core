import { RalObject } from "model/ral_object";

export interface RalObjectRepository {
    getRalObjectByUid(uid: string): Promise<RalObject>;

    getRalObjectsWithContainerId(containerId: string): Promise<RalObject[]>;

    getRalObjectsByRalType(ralType: string): Promise<RalObject[]>;

    createRalObject(ralObject: RalObject, overrideIfExists: boolean): Promise<void>;
}
