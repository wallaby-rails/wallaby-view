require 'test_helper'

class ThemeableTest < Minitest::Test
  def test_admin_application_controller_theme_metadata
    assert_equal Admin::ApplicationController.theme_name, 'secure'
    assert_equal Admin::ApplicationController.theme, theme_name: 'secure', theme_path: 'admin/application'
    assert_equal Admin::ApplicationController.themes, [{ theme_name: 'secure', theme_path: 'admin/application' }]
  end

  def test_admin_users_controller_theme_metadata
    assert_equal Admin::UsersController.theme_name, 'account'
    assert_equal Admin::UsersController.theme, theme_name: 'account', theme_path: 'admin/users'
    assert_equal Admin::UsersController.themes, [{ theme_name: 'account', theme_path: 'admin/users' }, { theme_name: 'secure', theme_path: 'admin/application' }]
  end

  def test_admin_user_profiles_controller_theme_metadata
    assert_equal Admin::UserProfilesController.theme_name, 'account'
    assert_equal Admin::UserProfilesController.theme, theme_name: 'account', theme_path: 'admin/users'
    assert_equal Admin::UserProfilesController.themes, [{ theme_name: 'account', theme_path: 'admin/users' }, { theme_name: 'secure', theme_path: 'admin/application' }]
  end
end
