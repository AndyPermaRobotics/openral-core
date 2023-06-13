import { RalMethod } from "model/ral_method";

///defines the interface for a repository that can be used to access RAL methods
export interface RalMethodRepository {
    ///returns the RalMethod with the given UID
    getByUid(uid: string): Promise<RalMethod>;

    ///returns all RalMethods with the given RalType
    getByRalType(ralType: string): Promise<RalMethod[]>;

    ///creates a new RalMethod. OverrideIfExists determines whether an existing RalMethod with the same UID should be overwritten.
    create(ralMethod: RalMethod, overrideIfExists: boolean): Promise<void>;
}
