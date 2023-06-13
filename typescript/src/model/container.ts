export class Container {
    constructor(
        public uid: string
    ) { }

    toMap(): Record<string, any> {
        return {
            'UID': this.uid,
        };
    }

    static fromMap(data: Record<string, any>): Container {
        const uid = data['UID'];
        if (uid == null) {
            throw new Error('UID is not defined in the map');
        }
        return new Container(uid);
    }
}