export class Identity {
    constructor(
        public uid: string,
        public name: string | null = null,
        public siteTag: string | null = null,
        public alternateIds: string[] = [],
        public alternateNames: string[] = []
    ) { }

    toMap(): Record<string, any> {
        return {
            "UID": this.uid,
            "name": this.name,
            "siteTag": this.siteTag,
            "alternateIDs": this.alternateIds,
            "alternateNames": this.alternateNames,
        };
    }

    static fromMap(data: Record<string, any>): Identity {
        const uid = data["UID"];
        if (uid == null) {
            throw new Error('UID is not defined in the map');
        }
        const name = data["name"] ?? null;
        const siteTag = data["siteTag"] ?? null;
        const alternateIds = data["alternateIDs"] ?? [];
        const alternateNames = data["alternateNames"] ?? [];
        return new Identity(uid, name, siteTag, alternateIds, alternateNames);
    }
}