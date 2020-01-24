require 'test_helper'

class PathSetTest < ActionView::TestCase
  test 'path_set typecast' do
    path_set = Wallaby::View::CustomPathSet.new [
      Rails.root
    ]
    path_set.paths.each do |path|
      assert_kind_of Wallaby::View::CustomResolver, path
    end

    path_set = Wallaby::View::CustomPathSet.new [
      ActionView::FileSystemResolver.new(Rails.root)
    ]
    path_set.paths.each do |path|
      assert_kind_of ActionView::FileSystemResolver, path
    end
  end
end
