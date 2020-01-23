module Locals
  class CellTemplateCellPartialHtml < ApplicationTemplate
    def to_template
      concat content_tag(:h1, h1)
      render('cell_partial', h2: 'h2 local variable')
    end
  end
end
