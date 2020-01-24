require 'test_helper'

class CellTest < ActionView::TestCase
  test 'cell responsd_to_missing' do
    assert_respond_to Wallaby::Cell.new(self, {}), :tag
  end
end
