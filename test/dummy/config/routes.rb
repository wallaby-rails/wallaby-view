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
    get 'template_assignment'
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

  resource :parent, only: []
  resource :child, only: [] do
    get 'cell_template_in_parent'
    get 'cell_template_in_child'
    get 'cell_template_cell_partial_in_parent'
    get 'cell_template_cell_partial_in_child'
  end

  resource :parent_theme, only: [] do
    get 'cell_layout_in_theme_one'
    get 'cell_template_cell_partial_in_theme_one'
    get 'cell_template_in_parent_theme'
    get 'cell_template_cell_partial_in_parent_theme'
  end

  resource :parent_theme_child_theme, only: [] do
    get 'cell_layout_in_theme_two'
    get 'cell_template_cell_partial_in_theme_two'
    get 'cell_template_in_parent_theme'
    get 'cell_template_cell_partial_in_parent_theme'
    get 'cell_template_in_child_theme'
    get 'cell_template_cell_partial_in_child_theme'
  end

  namespace :admin, only: [] do
    get 'display_prefixes', to: 'application#display_prefixes'

    resource :user, only: [] do
      get 'display_prefixes'
      get 'cell_template'
      get 'cell_template_cell_partial'
    end

    resource :user_profile, only: [] do
      get 'display_prefixes'
    end
  end

  resource :error, only: [] do
    get 'unknown'
  end

  resource :collection, only: [] do
    get 'array_partial'
    get 'cell_array_cell_partial'
  end
end
