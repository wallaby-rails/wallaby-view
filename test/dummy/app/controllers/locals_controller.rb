class LocalsController < ApplicationController
  layout false

  def cell_template_cell_partial
    render 'cell_template_cell_partial', locals: { h1: 'h1 local variable' }
  end

  def cell_template_assignment
    render 'cell_template_assignment', locals: { h1: 'h1 local variable' }
  end
end
