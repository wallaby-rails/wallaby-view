module Locals
  class CellTemplateAssignmentHtml < ApplicationTemplate
    def to_template
      concat content_tag(:h1, h1)
      h1 = 'changed h1 local variable'
      concat content_tag(:h2, h1)
      concat tag.h3(local_assigns[:h1])
    end
  end
end
