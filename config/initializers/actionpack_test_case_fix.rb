module ActionController
  module TemplateAssertions
    def reset_template_assertion
      RENDER_TEMPLATE_INSTANCE_VARIABLES.each do |instance_variable|
        variable_name = "@_#{instance_variable}"
        variable = instance_variable_get(variable_name)
        variable.clear if variable
      end
    end
  end
end
