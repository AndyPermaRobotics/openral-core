import { RalObject } from "model/ral_object";

export interface RalObjectRepository {
    getByUid(uid: string): Promise<RalObject>;

    getByContainerId(containerId: string): Promise<RalObject[]>;

    getByRalType(ralType: string): Promise<RalObject[]>;

    create(ralObject: RalObject, overrideIfExists: boolean): Promise<void>;
}
