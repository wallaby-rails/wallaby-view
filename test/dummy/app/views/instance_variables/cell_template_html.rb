module InstanceVariables
  class CellTemplateHtml < ApplicationTemplate
    def to_template
      content_tag(:h1, @h1)
    end
  end
end
