import { expect } from 'chai';
import { Template } from '../src/model/template';

import 'mocha';

describe('Template', () => {
    describe('.fromMap', () => {
        it('should return a Template instance with the correct properties', () => {
            const template_map = {
                RALType: 'type1',
                version: '1.0',
                objectStateTemplates: 'state1',
            };
            const template = Template.fromMap(template_map);
            expect(template).to.be.an.instanceOf(Template);
            expect(template.ralType).to.equal(template_map.RALType);
            expect(template.version).to.equal(template_map.version);
            expect(template.objectStateTemplates).to.equal(
                template_map.objectStateTemplates,
            );
        });

        it('should return a Template instance without object_state_templates if it is not present in the map', () => {
            const template_map = {
                RALType: 'type2',
                version: '2.0',
            };
            const template = Template.fromMap(template_map);
            expect(template).to.be.an.instanceOf(Template);
            expect(template.ralType).to.equal(template_map.RALType);
            expect(template.version).to.equal(template_map.version);
            expect(template.objectStateTemplates).to.equal("");
        });

        it('should throw an error if RALType is not defined in the map', () => {
            const map = {
                version: '1.0',
                objectStateTemplates: 'example'
            };
            expect(() => Template.fromMap(map)).to.throw('RALType is not defined in the map');
        });

        it('should throw an error if version is not defined in the map', () => {
            const map = {
                RALType: 'type2',
                objectStateTemplates: 'example'
            };
            expect(() => Template.fromMap(map)).to.throw('version is not defined in the map');
        });
    });
});
