
import { RalObject } from "model/ral_object";
import { RalObjectRepository } from "./ral_object_repository";

export class MockRalObjectRepository implements RalObjectRepository {
  docsByUid: Record<string, Record<string, any>>;
  docsByContainerId: Record<string, string[]>;

  constructor(
    docsByUid: Record<string, Record<string, any>>,
    docsByContainerId: Record<string, string[]>
  ) {
    this.docsByUid = docsByUid;
    this.docsByContainerId = docsByContainerId;
  }

  async getByUid(
    uid: string,
  ): Promise<RalObject> {
    const doc = this.docsByUid[uid];

    if (!doc) {
      throw new Error(`No RalObject found for uid '${uid}'`);
    }

    const ralObject = RalObject.fromMap(doc);

    return ralObject;
  }

  async getByContainerId(containerId: string): Promise<RalObject[]> {
    const uids = this.docsByContainerId[containerId];

    if (!uids) {
      return [];
    }

    const result: RalObject[] = [];

    for (const uid of uids) {
      const object = await this.getByUid(uid);
      result.push(object);
    }

    return result;
  }

  async getByRalType(ralType: string): Promise<RalObject[]> {
    const result: RalObject[] = [];

    for (const uid in this.docsByUid) {
      const object = await this.getByUid(uid);

      if (object.template.ralType === ralType) {
        result.push(object);
      }
    }

    return result;
  }

  async create(ralObject: RalObject, overrideIfExists: boolean) {
    if (!overrideIfExists && this.docsByUid[ralObject.identity.uid]) {
      throw new Error(
        `RalObject with uid '${ralObject.identity.uid}' already exists.`
      );
    }

    this.docsByUid[ralObject.identity.uid] = ralObject.toMap();

    // add the uid to docsByContainerId if it has a container.UID
    if (ralObject.currentGeoLocation.container) {
      const containerId = ralObject.currentGeoLocation.container.uid;

      if (!this.docsByContainerId[containerId]) {
        this.docsByContainerId[containerId] = [];
      }

      if (
        this.docsByContainerId[containerId].includes(ralObject.identity.uid) == false
      ) {
        this.docsByContainerId[containerId].push(ralObject.identity.uid);
      }
    }
  }
}