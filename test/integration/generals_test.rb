require 'test_helper'

class GeneralsTest < ActionDispatch::IntegrationTest
  test 'renders Cell template, Cell partial and normal partial' do
    get general_path

    assert_response :success
    assert_select 'html body h1', 'generals/show_html.rb'
    assert_select 'html body h1 + h2', 'generals/show/title_html.rb'
    assert_select 'h3', 'generals/show/_description.html.erb'
  end

  test 'renders normal template' do
    get template_general_path

    assert_response :success
    assert_select 'html body h1', 'generals/template.html.erb'
  end

  test 'renders Cell template' do
    get cell_template_general_path

    assert_response :success
    assert_select 'html body h1', 'generals/cell_template_html.rb'
  end

  test 'renders normal template and normal partial' do
    get template_partial_general_path

    assert_response :success
    assert_select 'html body h1', 'generals/template_partial.html.erb'
    assert_select 'html body h1 + h2', 'generals/_partial.html.erb'
  end

  test 'renders Cell template and normal partial' do
    get cell_template_partial_general_path

    assert_response :success
    assert_select 'html body h1', 'generals/cell_template_partial_html.rb'
    assert_select 'html body h1 + h2', 'generals/_partial.html.erb'
  end

  test 'renders normal template and Cell partial' do
    get template_cell_partial_general_path

    assert_response :success
    assert_select 'html body h1', 'generals/template_cell_partial.html.erb'
    assert_select 'html body h1 + h2', 'generals/cell_partial_html.rb'
  end

  test 'renders Cell template and Cell partial' do
    get cell_template_cell_partial_general_path

    assert_response :success
    assert_select 'html body h1', 'generals/cell_template_cell_partial_html.rb'
    assert_select 'html body h1 + h2', 'generals/cell_partial_html.rb'
  end
end
