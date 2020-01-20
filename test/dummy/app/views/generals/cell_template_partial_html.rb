module Generals
  class CellTemplatePartialHtml < ApplicationTemplate
    def file
      __FILE__
    end

    def to_template
      concat content_tag(:h1, to_render)
      concat content_tag(:h2, render('partial'))
    end
  end
end
