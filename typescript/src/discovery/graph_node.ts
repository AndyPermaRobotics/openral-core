import { DiscoveryDimension } from "discovery/discovery_dimension";
import { RalObject } from "model/ral_object";


export class GraphNode {
    data: RalObject;
    _childrenMap: Partial<Record<DiscoveryDimension, GraphNode[]>>;
    _parentsMap: Partial<Record<DiscoveryDimension, GraphNode[]>>;

    constructor(data: RalObject, childrenMap: Partial<Record<DiscoveryDimension, GraphNode[]>> | null = null, parentsMap: Partial<Record<DiscoveryDimension, GraphNode[]>> | null = null) {
        this.data = data;
        this._childrenMap = childrenMap || {};
        this._parentsMap = parentsMap || {};
    }

    addChildNode(dimension: DiscoveryDimension, node: GraphNode): void {
        if (!this._childrenMap[dimension]) {
            this._childrenMap[dimension] = [node];
        } else {
            this._childrenMap[dimension]!.push(node);
        }
    }

    addParentNode(dimension: DiscoveryDimension, node: GraphNode): void {
        if (!this._parentsMap[dimension]) {
            this._parentsMap[dimension] = [node];
        } else {
            this._parentsMap[dimension]!.push(node);
        }
    }

    allChildren(): GraphNode[] {
        const allChildren: GraphNode[] = [];

        Object.entries(this._childrenMap).forEach(([key, nodes]) => {
            allChildren.push(...nodes);
        });

        return allChildren;
    }

    children(dimension: DiscoveryDimension): GraphNode[] {
        return this._childrenMap[dimension] || [];
    }

    allParents(): GraphNode[] {
        const allParents: GraphNode[] = [];

        Object.values(this._parentsMap).forEach(nodes => {
            allParents.push(...nodes);
        });

        return allParents;
    }

    parents(dimension: DiscoveryDimension): GraphNode[] {
        return this._parentsMap[dimension] || [];
    }

    isRoot(dimension: DiscoveryDimension): boolean {
        return !this._parentsMap[dimension] || this._parentsMap[dimension]!.length === 0;
    }

    isLeaf(dimension: DiscoveryDimension): boolean {
        return !this._childrenMap[dimension] || this._childrenMap[dimension]!.length === 0;
    }

    depth(dimension: DiscoveryDimension): number {
        throw new Error("Method not implemented.");
    }

    getDescendants(dimension: DiscoveryDimension): GraphNode[] {
        throw new Error("Method not implemented.");
    }

    toString(): string {
        return `GraphNode(uid=${this.data.identity.uid})`;
    }

    getChildWithUid(uid: string, dimension: DiscoveryDimension | null = null): GraphNode | null {
        if (dimension === null) {

            let result: GraphNode | null = null;

            Object.values(this._childrenMap).forEach(graphNodes => {
                console.log("Iterate Values of " + this._childrenMap);
                console.log(graphNodes);

                const child = graphNodes.find(child => child.data.identity.uid === uid);

                if (child) {
                    result = child;
                }
            });

            return result;
        } else {
            if (!this._childrenMap[dimension]) {
                return null;
            }

            const child = this._childrenMap[dimension]!.find(child => child.data.identity.uid === uid);
            if (child) {
                return child;
            }
        }
        return null;
    }

    getParentWithUid(uid: string, dimension: DiscoveryDimension | null = null): GraphNode | null {
        if (dimension === null) {

            let result: GraphNode | null = null;

            Object.values(this._parentsMap).forEach(graphNodes => {
                const parent = graphNodes.find(parent => parent.data.identity.uid === uid);

                if (parent) {
                    result = parent;
                }

                return parent;
            });

            return result;

        } else {
            if (!this._parentsMap[dimension]) {
                return null;
            }

            const parent = this._parentsMap[dimension]!.find(parent => parent.data.identity.uid === uid);
            if (parent) {
                return parent;
            }
        }
        return null;
    }
}