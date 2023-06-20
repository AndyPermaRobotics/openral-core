import { expect } from 'chai';
import 'mocha';
import { DiscoveryDimension } from '../../src/discovery/discovery_dimension';
import { GraphNode } from '../../src/discovery/graph_node';
import { CurrentGeoLocation, Definition, Identity, RalObject, SpecificProperties, Template } from '../../src/model/ral_object';


//function to create example ral object
function createExampleRalObject(): RalObject {
    return new RalObject({
        identity: new Identity(
            "myUID",
            "thing",
        ),
        currentOwners: [],
        definition: new Definition(
            "",
            "",
        ),
        objectState: "undefined",
        template: new Template(
            "thing",
            "1",
            "generalObjectState",
        ),
        specificProperties: new SpecificProperties({}),
        currentGeoLocation: new CurrentGeoLocation(),
        locationHistoryRef: [],
        ownerHistoryRef: [],
        methodHistoryRef: [],
        linkedObjectRef: [],

    })
}


describe('GraphNode', () => {
    describe('.addChildNode', () => {
        it('creates an empty list, if dimension is not present yet', () => {
            //arrange
            let ralObject = createExampleRalObject();
            let node = new GraphNode(ralObject);

            //act
            node.addChildNode(DiscoveryDimension.ContainerId, new GraphNode(createExampleRalObject()));

            //assert
            expect(node.children(DiscoveryDimension.ContainerId)).to.have.lengthOf(1, "children() should be one element long");
            expect(node.allChildren()).to.have.lengthOf(1, "allChildren() should be one element long");
        });

        it('adds the node to the list, if dimension is present', () => {
            //arrange
            let ralObject = createExampleRalObject();
            let node = new GraphNode(ralObject, { [DiscoveryDimension.ContainerId]: [new GraphNode(createExampleRalObject())] });

            //act
            node.addChildNode(DiscoveryDimension.ContainerId, new GraphNode(createExampleRalObject()));

            //assert
            expect(node.children(DiscoveryDimension.ContainerId)).to.have.lengthOf(2, "children() should be one element long");
            expect(node.allChildren()).to.have.lengthOf(2, "allChildren() should be one element long");
        });
    });

    describe('.addParentNode', () => {
        it('creates an empty list, if dimension is not present yet', () => {
            //arrange
            let ralObject = createExampleRalObject();
            let node = new GraphNode(ralObject);

            //act
            node.addParentNode(DiscoveryDimension.ContainerId, new GraphNode(createExampleRalObject()));

            //assert
            expect(node.parents(DiscoveryDimension.ContainerId)).to.have.lengthOf(1, "parents() should be one element long");
            expect(node.allParents()).to.have.lengthOf(1, "allParents() should be one element long");
        });

        it('adds the node to the list, if dimension is present', () => {
            //arrange
            let ralObject = createExampleRalObject();
            let node = new GraphNode(ralObject, {}, { [DiscoveryDimension.ContainerId]: [new GraphNode(createExampleRalObject())] });

            //act
            node.addParentNode(DiscoveryDimension.ContainerId, new GraphNode(createExampleRalObject()));

            //assert
            expect(node.parents(DiscoveryDimension.ContainerId)).to.have.lengthOf(2, "parents() should be one element long");
            expect(node.allParents()).to.have.lengthOf(2, "allParents() should be one element long");
        });
    });

    describe('.getChildWithUid', () => {
        it('returns the child with the given UID in the dimension', () => {
            //arrange
            let ralObject = createExampleRalObject();
            let child = new GraphNode(ralObject);
            let node = new GraphNode(ralObject, { [DiscoveryDimension.ContainerId]: [child] });

            //act
            let result = node.getChildWithUid(ralObject.identity.uid, DiscoveryDimension.ContainerId);

            //assert
            expect(result).to.equal(child);
        });

        it('returns null, if the child with the given UID does not exist in the given dimension', () => {
            //arrange
            let ralObject = createExampleRalObject();
            let node = new GraphNode(ralObject);

            //act
            let result = node.getChildWithUid(ralObject.identity.uid, DiscoveryDimension.ContainerId);

            //assert
            expect(result).to.be.null;
        });

        it('returns the child with the given UID', () => {
            //arrange
            let ralObject = createExampleRalObject();
            let child = new GraphNode(ralObject);
            let node = new GraphNode(ralObject, { [DiscoveryDimension.ContainerId]: [child] });

            //act
            let result = node.getChildWithUid(ralObject.identity.uid);

            //assert
            expect(result).to.equal(child);
        });

        it('returns null, if the child with the given UID does not exist', () => {
            //arrange
            let ralObject = createExampleRalObject();
            let node = new GraphNode(ralObject);

            //act
            let result = node.getChildWithUid(ralObject.identity.uid);

            //assert
            expect(result).to.be.null;
        });

    });

    describe('.getParentWithUid', () => {
        it('returns the child with the given UID in the dimension', () => {
            //arrange
            let ralObject = createExampleRalObject();
            let child = new GraphNode(ralObject);
            let node = new GraphNode(ralObject, {}, { [DiscoveryDimension.ContainerId]: [child] });

            //act
            let result = node.getParentWithUid(ralObject.identity.uid, DiscoveryDimension.ContainerId);

            //assert
            expect(result).to.equal(child);
        });

        it('returns null, if the child with the given UID does not exist in the given dimension', () => {
            //arrange
            let ralObject = createExampleRalObject();
            let node = new GraphNode(ralObject);

            //act
            let result = node.getParentWithUid(ralObject.identity.uid, DiscoveryDimension.ContainerId);

            //assert
            expect(result).to.be.null;
        });

        it('returns the child with the given UID', () => {
            //arrange
            let ralObject = createExampleRalObject();
            let parent = new GraphNode(ralObject);
            let node = new GraphNode(ralObject, {}, { [DiscoveryDimension.ContainerId]: [parent] });

            //act
            let result = node.getParentWithUid(ralObject.identity.uid);

            //assert
            expect(result).to.equal(parent);
        });

        it('returns null, if the child with the given UID does not exist', () => {
            //arrange
            let ralObject = createExampleRalObject();
            let node = new GraphNode(ralObject);

            //act
            let result = node.getParentWithUid(ralObject.identity.uid);

            //assert
            expect(result).to.be.null;
        });

    });
});