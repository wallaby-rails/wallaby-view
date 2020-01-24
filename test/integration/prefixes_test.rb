require 'test_helper'

class PrefixesTest < ActionDispatch::IntegrationTest
  test 'admin application prefixes' do
    get admin_display_prefixes_path

    assert_response :success
    assert_equal JSON.parse(response.body), [
      'admin/application/display_prefixes',
      'admin/application',
      'secure/display_prefixes',
      'secure',
      'application/display_prefixes',
      'application'
    ]
  end

  test 'admin users prefixes' do
    get display_prefixes_admin_user_path

    assert_response :success
    assert_equal JSON.parse(response.body), [
      'admin/users/display_prefixes',
      'admin/users',
      'account/display_prefixes',
      'account',
      'admin/application/display_prefixes',
      'admin/application',
      'secure/display_prefixes',
      'secure',
      'application/display_prefixes',
      'application'
    ]
  end

  test 'admin user profiles prefixes' do
    get display_prefixes_admin_user_profile_path

    assert_response :success
    assert_equal JSON.parse(response.body), [
      'admin/user_profiles/display_prefixes',
      'admin/user_profiles',
      'admin/users/display_prefixes',
      'admin/users',
      'account/display_prefixes',
      'account',
      'admin/application/display_prefixes',
      'admin/application',
      'secure/display_prefixes',
      'secure',
      'application/display_prefixes',
      'application'
    ]
  end
end
