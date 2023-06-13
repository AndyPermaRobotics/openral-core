

export class SpecificProperty {
    constructor(
        public key: string,
        public value: any,
        public unit: string | null = null
    ) { }

    toMap(): Record<string, any> {
        return {
            "key": this.key,
            "value": this.value,
            "unit": this.unit
        };
    }

    static fromMap(propertyMap: Record<string, any>): SpecificProperty {
        const { key, value, unit } = propertyMap;

        //check that key and value are defined
        if (key == null) {
            throw new Error('key is not defined in the map');
        }
        if (value == null) {
            throw new Error('value is not defined in the map');
        }

        return new SpecificProperty(key, value, unit ?? null);
    }
}
