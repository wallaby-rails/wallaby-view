module ParentThemes
  class CellTemplateCellPartialInParentThemeHtml < ApplicationTemplate
    def file
      __FILE__
    end

    def to_template
      concat content_tag(:h1, to_render)
      render('parent_cell_partial')
    end
  end
end
