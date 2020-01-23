require 'test_helper'

class FormatsTest < ActionDispatch::IntegrationTest
  test 'renders template for html' do
    get cell_template_cell_partial_without_html_suffix_format_path

    assert_response :success
    assert_select 'h1', 'formats/cell_template_cell_partial_without_html_suffix.rb'
  end

  test 'renders template for json' do
    get \
      cell_template_cell_partial_without_html_suffix_format_path,
      as: :json,
      headers: {
        'ACCEPT' => 'application/json',
        'CONTENT_TYPE' => 'application/json'
      }

    assert_response :success
    assert_equal response.body, '{"something":"else"}'
  end
end
