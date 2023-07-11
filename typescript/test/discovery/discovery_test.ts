import { assert, expect } from 'chai';
import 'mocha';
import { Discovery } from '../../src/discovery/discovery';
import { DiscoveryDimension } from '../../src/discovery/discovery_dimension';
import { GraphNode } from '../../src/discovery/graph_node';
import { MockDataDiscovery } from './mock_data_discovery';


const eqSet = (xs: Set<string>, ys: Set<string>) =>
  xs.size === ys.size &&
  [...xs].every((x) => ys.has(x));


function checkRelationship(parentNode: GraphNode, expectedChildren: string[], dimension: DiscoveryDimension) {
  const childrenUids = parentNode.children(dimension).map((value) => value.data.identity.uid);

  if (expectedChildren.length === 0) {
    expect(childrenUids.length === 0, `The node ${parentNode.data.identity.uid} should have no children in dimension ${dimension}`);
  } else {
    expect(
      eqSet(new Set(childrenUids), new Set(expectedChildren)),
      `The node ${parentNode.data.identity.uid} should have the children '${expectedChildren}' in dimension ${dimension}, but has '${childrenUids}' children`
    ).to.be.true;
  }

  for (const childUid of expectedChildren) {
    const child = parentNode.getChildWithUid(childUid);
    expect(child !== null, `The node ${parentNode.data.identity.uid} should have the child '${childUid}' in dimension ${dimension}`);
    expect(
      child!.parents(dimension).includes(parentNode),
      `The node ${parentNode.data.identity.uid} should be a parent of ${childUid} in dimension ${dimension}`
    ).to.be.true;
  }

}



describe('Discovery', () => {
  describe('.execute', () => {
    it('', async () => {
      const ralRepository = MockDataDiscovery.getMockRalRepository();

      const discovery = new Discovery(ralRepository, await ralRepository.getByUid("Start"), "wurzel_type", DiscoveryDimension.ContainerId, [
        DiscoveryDimension.ContainerId,
        DiscoveryDimension.Owner,
        DiscoveryDimension.LinkedObjectRef,
      ]);

      const wurzel = await discovery.execute();


      assert(wurzel.data.template.ralType === "wurzel_type", "The root node should have the ral type 'wurzel_type'");
      assert(wurzel.data.identity.uid === "wurzel", "The root node should have the uid 'wurzel'");

      checkRelationship(wurzel, ["A", "B"], DiscoveryDimension.ContainerId);
      checkRelationship(wurzel, [], DiscoveryDimension.Owner);
      checkRelationship(wurzel, ["F"], DiscoveryDimension.LinkedObjectRef);

      const A = wurzel.getChildWithUid("A");
      assert(A !== null, "The root node should have a child with uid 'A'");
      checkRelationship(A, ["Start"], DiscoveryDimension.ContainerId);
      checkRelationship(A, ["F"], DiscoveryDimension.Owner);

      const B = wurzel.getChildWithUid("B");
      assert(B !== null, "The root node should have a child with uid 'B'");
      checkRelationship(B, ["C"], DiscoveryDimension.ContainerId);
      checkRelationship(B, [], DiscoveryDimension.Owner);

      const F = B.getParentWithUid("F");
      assert(F !== null, "'B' should have a parent with uid 'F'");
      checkRelationship(F, [], DiscoveryDimension.ContainerId);
      checkRelationship(F, ["B"], DiscoveryDimension.Owner);
      checkRelationship(F, ["wurzel"], DiscoveryDimension.LinkedObjectRef);

      const Start = A.getChildWithUid("Start");
      assert(Start !== null, "'A' should have a child with uid 'Start'");
      checkRelationship(Start, ["D"], DiscoveryDimension.ContainerId);
      checkRelationship(Start, ["F"], DiscoveryDimension.Owner);

      const C = B.getChildWithUid("C");
      assert(C !== null, "'B' should have a child with uid 'C'");
      checkRelationship(C, [], DiscoveryDimension.ContainerId);
      checkRelationship(C, [], DiscoveryDimension.Owner);

      const D = Start.getChildWithUid("D");
      assert(D !== null, "'Start' should have a child with uid 'D'");
      checkRelationship(D, [], DiscoveryDimension.ContainerId);
      checkRelationship(D, [], DiscoveryDimension.Owner);


    });

  });
});


