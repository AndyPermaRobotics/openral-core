import { RalMethod } from "model/ral_method";
import { RalMethodRepository } from "repository/ral_method_repository";


export class FirestoreRalMethodRepository implements RalMethodRepository {

    ///the firestore collection in which the RalMethods are stored
    private readonly firestoreCollection: FirebaseFirestore.CollectionReference;


    /**
     * @param {Object} params - The constructor parameters.
     * @param {FirebaseFirestore.CollectionReference} params.firestoreCollection - The firestore collection in which the RalMethods are stored.
    */
    constructor(params: { firestoreCollection: FirebaseFirestore.CollectionReference }) {
        this.firestoreCollection = params.firestoreCollection;
    }

    public async getByUid(uid: string): Promise<RalMethod> {
        const query = this.firestoreCollection.where("identity.uid", "==", uid);

        const ralMethods = await this.executeMultiQuery(query);

        if (ralMethods.length == 1) {
            return ralMethods[0];
        }
        else if (ralMethods.length == 0) {
            throw new Error(`RalMethod with uid ${uid} not found`);
        }
        else { //length > 1
            throw new Error(`RalMethod with uid ${uid} found multiple times`);
        }
    }

    public async getByRalType(ralType: string): Promise<RalMethod[]> {
        const query = this.firestoreCollection.where("template.RALType", "==", ralType);

        return await this.executeMultiQuery(query);
    }


    /**
     * 
     * @param ralMethod - The RalMethod to create.
     * @param overrideIfExists (default=false), If true, the RalMethod will be overwritten if it already exists. If false, an error will be thrown if the RalMethod already exists.
     */
    public async create(ralMethod: RalMethod, overrideIfExists: boolean = false): Promise<void> {
        if (overrideIfExists === false) {
            let docRef = await this.firestoreCollection.doc(ralMethod.identity.uid).get();
            if (docRef.exists) {
                throw new Error(`RalMethod with uid ${ralMethod.identity.uid} already exists`);
            }
        }

        if (ralMethod.identity.uid == null || ralMethod.identity.uid == "") {
            throw new Error(`RalMethod uid is required, but was '${ralMethod.identity.uid}'`);
        }

        await this.firestoreCollection.doc(ralMethod.identity.uid).set(ralMethod.toMap());

    }





    private async executeMultiQuery(query: FirebaseFirestore.Query<FirebaseFirestore.DocumentData>): Promise<RalMethod[]> {
        const querySnapshot = await query.get();
        const docs = querySnapshot.docs;

        const ralMethods = docs.map(doc => RalMethod.fromMap(doc.data()));

        return ralMethods;
    }

    ///returns a new unique uid for a RalMethod
    public getNewUid(): string {
        const docRef = this.firestoreCollection.doc();
        return docRef.id;
    }

}

