
///class for the template property of RalObjects and RalMethods
export class Template {
    constructor(
        public ralType: string,
        public version: string,
        public objectStateTemplates: string | null = null,
    ) { }

    toMap(): Record<string, any> {
        return {
            "RALType": this.ralType,
            "version": this.version,
            "objectStateTemplates": this.objectStateTemplates ?? null,
        };
    }

    static fromMap(map: Record<string, any>): Template {
        const { RALType, version, objectStateTemplates } = map;

        //check that RALType and version are defined
        if (RALType == null) {
            throw new Error('RALType is not defined in the map');
        }
        if (version == null) {
            throw new Error('version is not defined in the map');
        }

        return new Template(
            RALType,
            version,
            objectStateTemplates ?? ""
        );
    }
}