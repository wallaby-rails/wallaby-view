require 'test_helper'

class LocalsTest < ActionDispatch::IntegrationTest
  test 'renders locals' do
    get cell_template_cell_partial_locals_path

    assert_response :success
    assert_select 'html body h1', 'h1 local variable'
    assert_select 'html body h1 + h2', 'h2 local variable'
  end

  test 'renders locals assignment' do
    get cell_template_assignment_locals_path

    assert_response :success
    assert_select 'html body h1', 'h1 local variable'
    assert_select 'html body h1 + h2', 'changed h1 local variable'
  end
end
