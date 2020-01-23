module Shared
  class CellTemplatePartialHtml < ApplicationTemplate
    def file
      __FILE__
    end

    def to_template
      concat content_tag(:h1, to_render)
      render('shared/partial')
    end
  end
end
