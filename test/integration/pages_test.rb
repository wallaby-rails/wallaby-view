require 'test_helper'

class PagesTest < ActionDispatch::IntegrationTest
  test 'renders title html cell' do
    get pages_path

    assert_response :success
    assert_select 'h1', 'app/views/pages/title_html.rb'
  end
end
