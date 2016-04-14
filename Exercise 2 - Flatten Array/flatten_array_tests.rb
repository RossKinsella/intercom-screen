require 'test/unit'
require_relative './flatten_array.rb'

class FlattenArrayTest < Test::Unit::TestCase
  def test_nested_arrays
    array = [2,[3,5,7],[[11,[[13,[[[[[17],19]]]]]]]]]
    assert_equal(flatten(array), [2,3,5,7,11,13,17,19])
  end

  def test_already_flat_array
    array = [2,3,5]
    assert_equal(flatten(array), [2,3,5])
  end

  def test_empty_array
    array = []
    assert_equal(flatten(array), [])
  end

  def test_nested_empty_arrays
    array = [[[[]]]]
    assert_equal(flatten(array), [])
  end

  def test_null_item
    array = [2,3,[5,nil,7],[[[nil,[[19]]]]]]
    assert_equal(flatten(array), [2,3,5,7,19])
  end

  def test_invalid_input
    non_array = false
    assert_raise(ArgumentError) {
      flatten(non_array)
    }
  end

  def test_mixed_item_types
    array = [2, "a", [:a, [], test_empty_array,[true, {'item' => 3}]]]
    assert_equal(flatten(array), [2,"a", :a, test_empty_array, true,{'item' => 3}])
  end

end
