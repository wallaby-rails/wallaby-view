module InstanceVariables
  class CellTemplateHtml < ApplicationTemplate
    def to_template
      content_tag(:h1, assigns['h1'])
    end
  end
end
