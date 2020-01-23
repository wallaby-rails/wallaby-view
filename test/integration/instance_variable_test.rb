require 'test_helper'

class InstanceVariableTest < ActionDispatch::IntegrationTest
  test 'renders cell_template' do
    get cell_template_instance_variable_path

    assert_response :success
    assert_select 'html body h1', 'h1 instance variable'
  end

  test 'renders cell_template assignment' do
    get cell_template_assignment_instance_variable_path

    assert_response :success
    assert_select 'html body h1', 'h1 instance variable'
    assert_select 'html body h1 + h2', 'changed h1 instance variable'
  end
end
