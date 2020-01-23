Rails.application.routes.draw do
  resource :general, only: :show do
    get 'template'
    get 'cell_template'
    get 'template_partial'
    get 'cell_template_partial'
    get 'template_cell_partial'
    get 'cell_template_cell_partial'
  end

  resource :precedence, only: [] do
    get 'cell_template_first'
    get 'cell_partial_first'
    get 'cell_layout_first'
  end

  resource :locals, only: [] do
    get 'cell_template_cell_partial'
    get 'cell_template_assignment'
  end

  resource :instance_variable, only: [] do
    get 'cell_template'
    get 'cell_template_assignment'
  end

  resource :format, only: [] do
    get 'cell_template_cell_partial_without_html_suffix'
  end

  resource :absolute, only: [] do
    get 'template'
    get 'cell_template'
    get 'template_partial'
    get 'cell_template_partial'
    get 'template_cell_partial'
    get 'cell_template_cell_partial'
  end

  resource :parent
  resource :child
  resource :parent_theme
  resource :child_theme
end
