require 'test_helper'

class ParentThemeChildThemesTest < ActionDispatch::IntegrationTest
  test 'renders Cell layout in theme_two' do
    get cell_layout_in_theme_two_parent_theme_child_theme_path

    assert_response :success
    assert_select 'html head title', 'theme_two'
    assert_select 'html body h1', 'theme_two/cell_layout_in_theme_two_html.rb'
  end

  test 'renders Cell template Cell partial in theme_two' do
    get cell_template_cell_partial_in_theme_two_parent_theme_child_theme_path

    assert_response :success
    assert_select 'html head title', 'theme_two'
    assert_select 'html body h1', 'theme_two/cell_template_cell_partial_in_theme_two_html.rb'
    assert_select 'html body h1 + h2', 'theme_two/cell_partial_html.rb'
  end

  test 'renders Cell template in parent_theme' do
    get cell_template_in_parent_theme_parent_theme_child_theme_path

    assert_response :success
    assert_select 'html head title', 'theme_two'
    assert_select 'html body h1', 'parent_themes/cell_template_in_parent_theme_html.rb'
  end

  test 'renders Cell template Cell partial in parent_theme' do
    get cell_template_cell_partial_in_parent_theme_parent_theme_child_theme_path

    assert_response :success
    assert_select 'html head title', 'theme_two'
    assert_select 'html body h1', 'parent_themes/cell_template_cell_partial_in_parent_theme_html.rb'
    assert_select 'html body h1 + h2', 'parent_themes/parent_cell_partial_html.rb'
  end

  test 'renders Cell template in child_theme' do
    get cell_template_in_child_theme_parent_theme_child_theme_path

    assert_response :success
    assert_select 'html head title', 'theme_two'
    assert_select 'html body h1', 'parent_theme_child_themes/cell_template_in_child_theme_html.rb'
  end

  test 'renders Cell template Cell partial in child_theme' do
    get cell_template_cell_partial_in_child_theme_parent_theme_child_theme_path

    assert_response :success
    assert_select 'html head title', 'theme_two'
    assert_select 'html body h1', 'parent_theme_child_themes/cell_template_cell_partial_in_child_theme_html.rb'
    assert_select 'html body h1 + h2', 'parent_theme_child_themes/child_cell_partial_html.rb'
  end
end
