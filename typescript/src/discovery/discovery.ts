import { RalObject } from "model/ral_object_with_role";
import { RalObjectRepository } from "repository/ral_object_repository";
import { DiscoveryDimension } from "./discovery_dimension";
import { GraphNode } from "./graph_node";


export class Discovery {
    private primaryDiscoveryDimension: DiscoveryDimension;
    private discoveryDimensions: DiscoveryDimension[];
    private ralRepository: RalObjectRepository;
    private selfObject: RalObject;
    private rootNodeRalType: string;
    private objectRegistry: { [uid: string]: GraphNode } = {};

    constructor(
        ralRepository: RalObjectRepository,
        startObject: RalObject,
        rootNodeRalType: string,
        primaryDiscoveryDimension: DiscoveryDimension,
        discoveryDimensions: DiscoveryDimension[] = []
    ) {
        if (primaryDiscoveryDimension !== DiscoveryDimension.ContainerId) {
            throw new Error(`The primary discovery dimension must be ${DiscoveryDimension.ContainerId}.`);
        }

        this.primaryDiscoveryDimension = primaryDiscoveryDimension;
        this.discoveryDimensions = discoveryDimensions;
        this.ralRepository = ralRepository;
        this.selfObject = startObject;
        this.rootNodeRalType = rootNodeRalType;
    }

    public async execute(): Promise<GraphNode> {
        const topNodeObject = await this.getRootNodeObject();
        const root = new GraphNode(topNodeObject);
        this.objectRegistry[topNodeObject.identity.uid] = root;
        await this.loadDependenciesForNodeRecursively(root);
        return root;
    }

    private async loadDependenciesForNodeRecursively(node: GraphNode): Promise<void> {
        const allNewNodes: GraphNode[] = [];

        for (const dimension of this.discoveryDimensions) {
            if (dimension === DiscoveryDimension.ContainerId) {
                const ralObjects = await this.getChildrenForDimension(node.data, dimension);
                const newNodes = this.integrateObjects(ralObjects, node, dimension, true);
                allNewNodes.push(...newNodes);
            } else if (dimension === DiscoveryDimension.Owner) {
                const ralObjects = await this.getParentsForDimension(node.data, dimension);
                const newNodes = this.integrateObjects(ralObjects, node, dimension, false);
                allNewNodes.push(...newNodes);
            } else if (dimension === DiscoveryDimension.LinkedObjectRef) {
                const ralObjects = await this.getChildrenForDimension(node.data, dimension);
                const newNodes = this.integrateObjects(ralObjects, node, dimension, true);
                allNewNodes.push(...newNodes);
            } else {
                throw new Error(`Dimension ${dimension} is not supported yet.`);
            }
        }

        console.log(`Loaded new nodes: ${allNewNodes} by loading dependencies for node: ${node}`);

        for (const newNode of allNewNodes) {
            await this.loadDependenciesForNodeRecursively(newNode);
        }
    }

    private integrateObjects(
        ralObjects: RalObject[],
        currentNode: GraphNode,
        dimension: DiscoveryDimension,
        asChild: boolean
    ): GraphNode[] {
        const newNodes: GraphNode[] = [];

        for (const ralObject of ralObjects) {
            let graphNode: GraphNode;

            if (ralObject.identity.uid in this.objectRegistry) {
                graphNode = this.objectRegistry[ralObject.identity.uid];
            } else {
                graphNode = new GraphNode(ralObject);
                this.objectRegistry[ralObject.identity.uid] = graphNode;
                newNodes.push(graphNode);
            }

            if (asChild) {
                graphNode.addParentNode(dimension, currentNode);
                currentNode.addChildNode(dimension, graphNode);
            } else {
                graphNode.addChildNode(dimension, currentNode);
                currentNode.addParentNode(dimension, graphNode);
            }
        }

        console.log(`Integrate ${ralObjects.map((obj) => obj.identity.uid)} with ${dimension} into ${currentNode}`);

        return newNodes;
    }

    private async getRootNodeObject(): Promise<RalObject> {
        let currentObject = this.selfObject;

        while (currentObject.template.ralType !== this.rootNodeRalType) {
            const ralObjects = await this.getParentsForDimension(currentObject, this.primaryDiscoveryDimension);

            if (ralObjects.length === 0) {
                throw new Error(
                    `RootNodeDiscovery failed: RalObject '${currentObject}' has no parent with dimension '${this.primaryDiscoveryDimension}'.`
                );
            }

            if (ralObjects.length > 1) {
                throw new Error(
                    `RootNodeDiscovery failed: RalObject '${currentObject}' has more than one parent with dimension '${this.primaryDiscoveryDimension}'. This is not supported for the RootNodeDiscovery.`
                );
            }

            currentObject = ralObjects[0];
        }

        return currentObject;
    }

    private async getChildrenForDimension(ralObject: RalObject, dimension: DiscoveryDimension): Promise<RalObject[]> {
        if (dimension === DiscoveryDimension.ContainerId) {
            return await this.ralRepository.getByContainerId(ralObject.identity.uid);
        } else if (dimension === DiscoveryDimension.LinkedObjectRef) {
            const linkedObjRef = ralObject.linkedObjectRef;
            const ralObjects: RalObject[] = [];

            for (const ref of linkedObjRef) {
                const ralObject = await this.ralRepository.getByUid(ref.uid);
                ralObjects.push(ralObject);
            }

            return ralObjects;
        } else {
            throw new Error(`Dimension ${dimension} is not supported to find children yet.`);
        }
    }

    private async getParentsForDimension(ralObject: RalObject, dimension: DiscoveryDimension): Promise<RalObject[]> {
        if (dimension === DiscoveryDimension.ContainerId) {
            const object = await this.getParentByContainerId(ralObject);
            return [object];
        } else if (dimension === DiscoveryDimension.Owner) {
            const owners = ralObject.currentOwners;
            const ralObjects: RalObject[] = [];

            for (const owner of owners) {
                const ralObject = await this.ralRepository.getByUid(owner.uid);
                ralObjects.push(ralObject);
            }

            return ralObjects;
        } else {
            throw new Error(`Dimension ${dimension} is not supported to find parents yet.`);
        }
    }

    private async getParentByContainerId(ralObject: RalObject): Promise<RalObject> {
        const containerId = this.getContainerIdOrFail(ralObject);
        return await this.ralRepository.getByUid(containerId);
    }

    private getContainerIdOrFail(ralObject: RalObject): string {
        const container = ralObject.currentGeoLocation.container;
        const containerId = container?.uid;

        if (containerId === undefined) {
            throw new Error(`ContainerId of ralObject '${ralObject}' is null.`);
        }

        return containerId;
    }
}