require 'json'

class CustomerFinder
  RADIUS_OF_EARTH_IN_KM = 6371
  OFFICE_LATITUDE = 53.3381985
  OFFICE_LONGITUDE = -6.2592576

  def self.find_nearby_customers
    customers = read_customers
    invited_customers = []

    customers.each do |customer|
      distance_to_office = distance_in_km(
          customer['latitude'].to_f,
          customer['longitude'].to_f,
          OFFICE_LATITUDE,
          OFFICE_LONGITUDE
      )

      if distance_to_office < 100
        invited_customers.push({ name: customer['name'], user_id: customer['user_id']})
      end
    end

    invited_customers.sort_by{ |invited_customer| invited_customer[:user_id]}
  end

  private

    def self.read_customers
      customers = []
      customers_file = File.open('./customers.txt')
      customers_file.each_line do |customer_json|
        customers.push JSON.parse customer_json
      end
      customers
    end

    def self.to_radians degrees
      degrees * Math::PI / 180
    end

    def self.distance_in_km lat1, long1, lat2, long2
      delta_lat_radians = (to_radians (lat1 - lat2)).abs
      delta_long_radians = (to_radians (long1 - long2)).abs
      lat1_radians = to_radians lat1
      lat2_radians = to_radians lat2

      haversine_of_central_angle =
          Math.sin(delta_lat_radians/2)**2 +
          Math.cos(lat1_radians) * Math.cos(lat2_radians) *
          Math.sin(delta_long_radians/2)**2

      central_angle =
          2 * Math::atan2(
              Math::sqrt(haversine_of_central_angle),
              Math::sqrt(1-haversine_of_central_angle)
          )

      RADIUS_OF_EARTH_IN_KM * central_angle
    end

end
