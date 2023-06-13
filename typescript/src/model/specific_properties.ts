import { SpecificProperty } from './specific_property';

///class for the specificProperties property of RalObjects and RalMethods
export class SpecificProperties {
    private _specificProperties: Record<string, SpecificProperty>;

    constructor(specificProperties: Record<string, SpecificProperty>) {
        this._specificProperties = specificProperties;
    }

    getValueOf(key: string): any | null {
        const specificProperty = this._specificProperties[key];
        return specificProperty?.value ?? null;
    }

    containsKey(key: string): boolean {
        return key in this._specificProperties;
    }

    getProperty(key: string): SpecificProperty | null {
        const specificProperty = this._specificProperties[key];
        return specificProperty ? new SpecificProperty(specificProperty.key, specificProperty.value, specificProperty.unit ?? null) : null;
    }

    get map(): Record<string, SpecificProperty> {
        return { ...this._specificProperties };
    }

    /// returns the number of specific properties
    get count() {
        return Object.keys(this._specificProperties).length;
    }

    ///returns the specific properties as an array of maps
    toMaps(): Record<string, SpecificProperty>[] {
        return Object.values(this._specificProperties).map((value) => value.toMap());
    }

    static fromMaps(data: any): SpecificProperties {
        if (data === null || data === undefined) {
            return new SpecificProperties({});
        }

        if (!Array.isArray(data)) {
            throw new Error(`data must be an array, but was ${typeof data}`);
        }

        const specificProperties: Record<string, SpecificProperty> = {};
        for (const item of data) {

            if (typeof item !== 'object' || item === null) {
                throw new Error(`item must be an object, but was ${typeof item}`);
            }
            const specificProperty = SpecificProperty.fromMap(item);
            specificProperties[specificProperty.key] = specificProperty;
        }

        return new SpecificProperties(specificProperties);
    }
}
