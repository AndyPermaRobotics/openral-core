export class ObjectRef {

    uid: string;
    role: string | null;

    constructor(params: { uid: string, role: string | null }) {
        this.uid = params.uid;
        this.role = params.role;
    }

    toMap(): Record<string, any> {
        return {
            UID: this.uid,
            role: this.role
        }
    }

    static fromMap(map: Record<string, any>): ObjectRef {

        const uid = map.UID;
        const role = map.role;

        if (uid == null) {
            throw new Error("uid is required");
        } else if (typeof uid !== "string") {
            throw new Error("uid must be a string");
        }

        return new ObjectRef({
            uid: uid,
            role: role
        });
    }

}