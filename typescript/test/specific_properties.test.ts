import { expect } from 'chai';
import { SpecificProperties } from '../src/model/specific_properties';

describe('SpecificProperties', () => {
    describe('.fromMap', () => {
        it('should return a SpecificProperties instance with the correct items', () => {
            const data = [
                {
                    key: 'key1',
                    value: 'value1',
                    unit: 'unit1',
                },
                {
                    key: 'key2',
                    value: 'value2',
                }
            ];
            const specificProperties = SpecificProperties.fromMaps(data);
            expect(specificProperties).to.be.an.instanceOf(SpecificProperties);

            expect(specificProperties.getValueOf('key1')).to.equal('value1');
            expect(specificProperties.getValueOf('key2')).to.equal('value2');

            expect(specificProperties.getProperty('key1')?.unit).to.equal('unit1');
            expect(specificProperties.getProperty('key2')?.unit).to.be.null;

        });
    });
});
