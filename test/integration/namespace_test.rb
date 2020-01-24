require 'test_helper'

class NamespaceTest < ActionDispatch::IntegrationTest
  test 'renders Cell template' do
    get cell_template_admin_user_path

    assert_response :success
    assert_select 'html body h1', 'admin/users/cell_template_html.rb'
  end

  test 'renders Cell template Cell partial' do
    get cell_template_cell_partial_admin_user_path

    assert_response :success
    assert_select 'html body h1', 'admin/users/cell_template_cell_partial_html.rb'
    assert_select 'html body h1 + h2', 'admin/users/cell_partial_html.rb'
  end
end
