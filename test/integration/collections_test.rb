require 'test_helper'

class CollectionsTest < ActionDispatch::IntegrationTest
  test 'renders array partial' do
    puts Benchmark.measure { get array_partial_collection_path }

    assert_response :success

    assert_select 'h2', 100
  end

  test 'renders Cell array Cell partial' do
    puts Benchmark.measure { get cell_array_cell_partial_collection_path }

    assert_response :success

    assert_select 'h2', 100
  end
end
