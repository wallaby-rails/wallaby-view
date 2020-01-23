class AbsolutesController < ApplicationController
  layout false

  def template
    render 'shared/template'
  end

  def cell_template
    render 'shared/cell_template'
  end

  def template_partial
    render 'shared/template_partial'
  end

  def cell_template_partial
    render 'shared/cell_template_partial'
  end

  def template_cell_partial
    render 'shared/template_cell_partial'
  end

  def cell_template_cell_partial
    render 'shared/cell_template_cell_partial'
  end
end
