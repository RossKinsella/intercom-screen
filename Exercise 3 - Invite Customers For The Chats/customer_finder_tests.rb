require 'test/unit'
require_relative './customer_finder.rb'

class CustomerFinderTest < Test::Unit::TestCase

  def test_to_radians
    fourty_two_in_radians = 0.733038 # https://www.google.ie/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=42+degrees+in+radians
    assert_equal(fourty_two_in_radians, CustomerFinder.send(:to_radians, 42).round(6))
  end

  # From what the writer understands of computing the distance between two gps coordinates,
  # different formulas may produce different results. Therefore allow a margin of error.
  def test_distance_in_km
    third_party_distance_in_km = 313.92 # http://boulter.com/gps/distance/?from=53.3381985%2C+-6.2592576&to=51.92893%2C+-10.27699&units=k
    margin_of_error_in_km = 2

    args = 51.92893, -10.27699, 53.3381985, -6.2592576
    assert_in_delta(third_party_distance_in_km, CustomerFinder.send(:distance_in_km, *args), margin_of_error_in_km)
  end

  def test_customer_credentials_are_returned
    nearby_customers = CustomerFinder.find_nearby_customers

    assert_block do
      nearby_customers.none? {|customer| customer['name'] == false || customer['user_id'] == false}
    end
  end

  def test_customer_ids_are_in_asc_order
    nearby_customers = CustomerFinder.find_nearby_customers

    assert_block do
      nearby_customers.each_cons(2).all? { |a, b|
          ((a['user_id'] <=> b['user_id']) <= 0)
      }
    end
  end

end
