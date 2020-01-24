require 'test_helper'

class ErrorsTest < ActionDispatch::IntegrationTest
  test 'renders Cell template, Cell partial and normal partial' do
    get unknown_error_path

    assert_response :error
  end
end
