require 'test_helper'

class PrecedencesTest < ActionDispatch::IntegrationTest
  test 'renders Cell template before normal template' do
    get cell_template_first_precedence_path

    assert_response :success
    assert_select 'html body h1', 'precedences/cell_template_first_html.rb'
  end

  test 'renders Cell partial before normal partial' do
    get cell_partial_first_precedence_path

    assert_response :success
    assert_select 'html body h1', 'precedences/cell_partial_first_html.rb'
    assert_select 'html body h1 + h2', 'precedences/cell_partial_html.rb'
  end

  test 'renders Cell layout before normal layout' do
    get cell_layout_first_precedence_path

    assert_response :success
    assert_select 'html body h1', 'precedences/cell_layout_first_html.rb'
    assert_select 'html head title', 'cell layout'
  end
end
