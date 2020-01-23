class InstanceVariablesController < ApplicationController
  layout false

  def cell_template
    @h1 = 'h1 instance variable'
  end

  def cell_template_assignment
    @h1 = 'h1 instance variable'
  end
end
