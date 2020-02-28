require 'test_helper'

class PrefixesTest < ActionDispatch::IntegrationTest
  test 'admin application prefixes' do
    get admin_prefixes_path

    assert_response :success
    assert_equal JSON.parse(response.body), [
      'admin/application/prefixes',
      'admin/application',
      'secure/prefixes',
      'secure',
      'application/prefixes',
      'application'
    ]
  end

  test 'admin users prefixes' do
    get prefixes_admin_user_path

    assert_response :success
    assert_equal JSON.parse(response.body), [
      'admin/users/prefixes',
      'admin/users',
      'account/prefixes',
      'account',
      'admin/application/prefixes',
      'admin/application',
      'secure/prefixes',
      'secure',
      'application/prefixes',
      'application'
    ]
  end

  test 'admin user profiles prefixes' do
    get prefixes_admin_user_profile_path

    assert_response :success
    assert_equal JSON.parse(response.body), [
      'admin/user_profiles/prefixes',
      'admin/user_profiles',
      'admin/users/prefixes',
      'admin/users',
      'account/prefixes',
      'account',
      'admin/application/prefixes',
      'admin/application',
      'secure/prefixes',
      'secure',
      'application/prefixes',
      'application'
    ]
  end

  test 'admin custom' do
    get prefixes_admin_custom_path

    assert_response :success
    assert_equal JSON.parse(response.body), [
      'super/man/prefixes',
      'super/man/form',
      'super/man',
      'admin/customs/prefixes',
      'admin/customs/form',
      'admin/customs',
      'admin/users/prefixes',
      'admin/users/form',
      'admin/users',
      'account/prefixes',
      'account/form',
      'account',
      'admin/application/prefixes',
      'admin/application/form',
      'admin/application',
      'secure/prefixes',
      'secure/form',
      'secure',
      'application/prefixes',
      'application/form',
      'application'
    ]
  end

  test 'admin custom child' do
    get prefixes_admin_custom_child_path

    assert_response :success
    assert_equal JSON.parse(response.body), [
      'admin/custom_children/prefixes',
      'admin/custom_children/form',
      'admin/custom_children',
      'super/man/prefixes',
      'super/man/form',
      'super/man',
      'admin/customs/prefixes',
      'admin/customs/form',
      'admin/customs',
      'admin/users/prefixes',
      'admin/users/form',
      'admin/users',
      'account/prefixes',
      'account/form',
      'account',
      'admin/application/prefixes',
      'admin/application/form',
      'admin/application',
      'secure/prefixes',
      'secure/form',
      'secure',
      'application/prefixes',
      'application/form',
      'application'
    ]
  end

  test 'admin user profiles show and its partial' do
    get admin_user_profile_path

    assert_response :success
    assert_select 'h4', 100
  end
end
