module Shared
  class CellTemplateCellPartialHtml < ApplicationTemplate
    def file
      __FILE__
    end

    def to_template
      concat content_tag(:h1, to_render)
      render('shared/cell_partial')
    end
  end
end
