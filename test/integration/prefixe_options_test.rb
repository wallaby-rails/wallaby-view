require 'test_helper'

class PrefixOptionsTest < ActionDispatch::IntegrationTest
  test 'admin custom' do
    get prefix_options_admin_custom_path

    assert_response :success
    assert_equal JSON.parse(response.body), { 'prefixes' => ['form'] }
  end

  test 'admin custom child' do
    get prefix_options_admin_custom_child_path

    assert_response :success
    assert_equal JSON.parse(response.body), { 'prefixes' => ['form'] }
  end

  test 'admin custom grand child' do
    get prefix_options_admin_custom_grand_child_path

    assert_response :success
    assert_equal JSON.parse(response.body), { 'prefixes' => ['form'], 'index' => 'grand' }
  end
end
