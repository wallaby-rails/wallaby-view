# frozen_string_literal: true

require 'test_helper'

class ThemeableTest < Minitest::Test
  def test_admin_application_controller_theme_metadata
    assert_equal Admin::ApplicationController.theme_name, 'secure'
    assert_equal Admin::ApplicationController._layout, 'secure'
    assert_equal Admin::ApplicationController.theme, theme_name: 'secure', theme_path: 'admin/application'
    assert_equal Admin::ApplicationController.themes, [{ theme_name: 'secure', theme_path: 'admin/application' }]
  end

  def test_admin_users_controller_theme_metadata
    assert_equal Admin::UsersController.theme_name, 'account'
    assert_equal Admin::UsersController._layout, 'account'
    assert_equal Admin::UsersController.theme, theme_name: 'account', theme_path: 'admin/users'
    assert_equal Admin::UsersController.themes, [{ theme_name: 'account', theme_path: 'admin/users' }, { theme_name: 'secure', theme_path: 'admin/application' }]
  end

  def test_admin_user_profiles_controller_theme_metadata
    assert_equal Admin::UserProfilesController.theme_name, 'account'
    assert_equal Admin::UserProfilesController._layout, 'account'
    assert_equal Admin::UserProfilesController.theme, theme_name: 'account', theme_path: 'admin/users'
    assert_equal Admin::UserProfilesController.themes, [{ theme_name: 'account', theme_path: 'admin/users' }, { theme_name: 'secure', theme_path: 'admin/application' }]
  end

  def test_collections_controller_default_theme_metadata
    assert_nil CollectionsController.theme_name
    assert_nil CollectionsController._layout
    assert_nil CollectionsController.theme
    assert_equal CollectionsController.themes, []
  end

  def test_collections_controller_theme_metadata_set_to_false
    CollectionsController.theme_name = false
    assert_nil CollectionsController.theme_name
    assert_equal CollectionsController._layout, false
    assert_nil CollectionsController.theme
    assert_equal CollectionsController.themes, []

    CollectionsController.theme_name = nil
    assert_nil CollectionsController.theme_name
    assert_nil CollectionsController._layout
  end

  def test_collections_controller_theme_metadata_reset_to_nil
    CollectionsController.theme_name = 'test'
    assert_equal CollectionsController.theme_name, 'test'
    assert_equal CollectionsController._layout, 'test'
    assert_equal CollectionsController.theme, theme_name: 'test', theme_path: 'collections'
    assert_equal CollectionsController.themes, [{ theme_name: 'test', theme_path: 'collections' }]

    CollectionsController.theme_name = nil
    assert_nil CollectionsController.theme_name
    assert_nil CollectionsController._layout
  end
end
