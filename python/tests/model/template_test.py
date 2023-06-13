from openral_py.model.template import Template


class TestTemplate:
    def test_from_map_with_object_state_templates(self):
        template_map = {'RALType': 'Test', 'version': '1.0', 'objectStateTemplates': 'test_template'}
        template = Template.from_map(template_map)
        assert template.ral_type == 'Test'
        assert template.version == '1.0'
        assert template.object_state_templates == 'test_template'

    def test_from_map_without_object_state_templates(self):
        template_map = {'RALType': 'Test', 'version': '1.0'}
        template = Template.from_map(template_map)
        assert template.ral_type == 'Test'
        assert template.version == '1.0'
        assert template.object_state_templates is None

    def test_to_map(self):
        template = Template('Test', '1.0', 'test_template')
        template_map = template.to_map()
        assert template_map == {'RALType': 'Test', 'version': '1.0', 'objectStateTemplates': 'test_template'}
