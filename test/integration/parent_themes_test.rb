require 'test_helper'

class ParentThemesTest < ActionDispatch::IntegrationTest
  test 'renders Cell layout in theme_one' do
    get cell_layout_in_theme_one_parent_theme_path

    assert_response :success
    assert_select 'html head title', 'theme_one'
    assert_select 'html body h1', 'theme_one/cell_layout_in_theme_one_html.rb'
  end

  test 'renders Cell template Cell partial in theme_one' do
    get cell_template_cell_partial_in_theme_one_parent_theme_path

    assert_response :success
    assert_select 'html body h1', 'theme_one/cell_template_cell_partial_in_theme_one_html.rb'
    assert_select 'html body h1 + h2', 'theme_one/cell_partial_html.rb'
  end

  test 'renders Cell template in parent_theme' do
    get cell_template_in_parent_theme_parent_theme_path

    assert_response :success
    assert_select 'html body h1', 'parent_themes/cell_template_in_parent_theme_html.rb'
  end

  test 'renders Cell template Cell partial in parent_theme' do
    get cell_template_cell_partial_in_parent_theme_parent_theme_path

    assert_response :success
    assert_select 'html body h1', 'parent_themes/cell_template_cell_partial_in_parent_theme_html.rb'
    assert_select 'html body h1 + h2', 'parent_themes/parent_cell_partial_html.rb'
  end
end
