require 'test_helper'

class AbsolutesTest < ActionDispatch::IntegrationTest
  test 'renders absolute template' do
    get template_absolute_path

    assert_response :success
    assert_select 'h1', 'shared/template.html.erb'
  end

  test 'renders absolute Cell template' do
    get cell_template_absolute_path

    assert_response :success
    assert_select 'h1', 'shared/cell_template_html.rb'
  end

  test 'renders absolute template partial' do
    get template_partial_absolute_path

    assert_response :success
    assert_select 'h1', 'shared/template_partial.html.erb'
    assert_select 'h1 + h2', 'shared/_partial.html.erb'
  end

  test 'renders absolute Cell template partial' do
    get cell_template_partial_absolute_path

    assert_response :success
    assert_select 'h1', 'shared/cell_template_partial_html.rb'
    assert_select 'h1 + h2', 'shared/_partial.html.erb'
  end

  test 'renders absolute template Cell partial' do
    get template_cell_partial_absolute_path

    assert_response :success
    assert_select 'h1', 'shared/template_cell_partial.html.erb'
    assert_select 'h1 + h2', 'shared/cell_partial_html.rb'
  end

  test 'renders absolute Cell template Cell partial' do
    get cell_template_cell_partial_absolute_path

    assert_response :success
    assert_select 'h1', 'shared/cell_template_cell_partial_html.rb'
    assert_select 'h1 + h2', 'shared/cell_partial_html.rb'
  end
end
