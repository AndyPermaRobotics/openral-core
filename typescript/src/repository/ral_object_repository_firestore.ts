import { RalObject } from "model/ral_object";
import { RalObjectRepository } from "repository/ral_object_repository";


export class FirestoreRalObjectRepository implements RalObjectRepository {

    ///the firestore collection in which the RalObjects are stored
    private readonly firestoreCollection: FirebaseFirestore.CollectionReference;


    /**
     * @param {Object} params - The constructor parameters.
     * @param {FirebaseFirestore.CollectionReference} params.firestoreCollection - The firestore collection in which the RalObjects are stored.
    */
    constructor(params: { firestoreCollection: FirebaseFirestore.CollectionReference }) {
        this.firestoreCollection = params.firestoreCollection;
    }

    /**
     * 
     * @param ralObject - The RalObject to create.
     * @param overrideIfExists - If true, the RalObject will be overwritten if it already exists. If false, an error will be thrown if the RalObject already exists.
     */
    public async createRalObject(ralObject: RalObject, overrideIfExists: boolean = true): Promise<void> {

        if (overrideIfExists === false) {

            let docRef = await this.firestoreCollection.doc(ralObject.identity.uid).get();
            if (docRef.exists) {
                throw new Error(`RalObject with uid ${ralObject.identity.uid} already exists`);
            }
        }

        if (ralObject.identity.uid == null || ralObject.identity.uid == "") {
            throw new Error(`RalObject uid is required, but was '${ralObject.identity.uid}'`);
        }

        await this.firestoreCollection.doc(ralObject.identity.uid).set(ralObject.toMap());

    }

    public async getRalObjectByUid(uid: string): Promise<RalObject> {
        const query = this.firestoreCollection.where("identity.uid", "==", uid);

        const resultObjects = await this.executeMultiQuery(query);

        if (resultObjects.length == 1) {
            return resultObjects[0];
        }
        else if (resultObjects.length == 0) {
            throw new Error(`RalObject with uid ${uid} not found`);
        }
        else { //length > 1
            throw new Error(`RalObject with uid ${uid} found multiple times`);
        }
    }

    public async getRalObjectsWithContainerId(containerId: string): Promise<RalObject[]> {
        const query = this.firestoreCollection.where("currentGeolocation.container.UID", "==", containerId);

        return await this.executeMultiQuery(query);
    }

    public async getRalObjectsByRalType(ralType: string): Promise<RalObject[]> {
        const query = this.firestoreCollection.where("template.RALType", "==", ralType);

        return await this.executeMultiQuery(query);
    }


    private async executeMultiQuery(query: FirebaseFirestore.Query<FirebaseFirestore.DocumentData>): Promise<RalObject[]> {
        const querySnapshot = await query.get();
        const docs = querySnapshot.docs;

        const ralObjects = docs.map(doc => RalObject.fromMap(doc.data()));

        return ralObjects;
    }

    ///returns a new unique uid for a RalObject
    public getNewUid(): string {
        const docRef = this.firestoreCollection.doc();
        return docRef.id;
    }

}

