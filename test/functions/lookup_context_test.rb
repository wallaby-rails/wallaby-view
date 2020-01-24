require 'test_helper'

class LookupContextTest < ActionView::TestCase
  test 'view_paths=' do
    lc = Wallaby::View::CustomLookupContext.convert lookup_context
    lc.view_paths = [Rails.root]
    assert_kind_of Wallaby::View::CustomPathSet, lc.view_paths
  end
end
