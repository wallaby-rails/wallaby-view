module InstanceVariables
  class CellTemplateAssignmentHtml < ApplicationTemplate
    def to_template
      concat content_tag(:h1, @h1)
      @h1 = 'changed h1 instance variable'
      render('cell_partial')
    end
  end
end
