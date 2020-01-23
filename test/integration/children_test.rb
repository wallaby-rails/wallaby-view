require 'test_helper'

class ChildrenTest < ActionDispatch::IntegrationTest
  test 'renders parent Cell template' do
    get cell_template_in_parent_child_path

    assert_response :success
    assert_select 'h1', 'parents/cell_template_in_parent_html.rb'
  end

  test 'renders child Cell template' do
    get cell_template_in_child_child_path

    assert_response :success
    assert_select 'h1', 'children/cell_template_in_child_html.rb'
  end

  test 'renders parent Cell template Cell partial' do
    get cell_template_cell_partial_in_parent_child_path

    assert_response :success
    assert_select 'h1', 'parents/cell_template_cell_partial_in_parent_html.rb'
    assert_select 'h1 + h2', 'children/cell_partial_html.rb'
  end

  test 'renders child Cell template Cell partial' do
    get cell_template_cell_partial_in_child_child_path

    assert_response :success
    assert_select 'h1', 'children/cell_template_cell_partial_in_child_html.rb'
    assert_select 'h1 + h2', 'children/cell_partial_html.rb'
  end
end
