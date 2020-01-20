module Precedences
  class CellPartialFirstHtml < ApplicationTemplate
    def file
      __FILE__
    end

    def to_template
      concat content_tag(:h1, to_render)
      concat render('cell_partial')
    end
  end
end
