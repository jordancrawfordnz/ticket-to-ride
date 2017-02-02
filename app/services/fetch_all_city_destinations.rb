class FetchAllCityDestinations
  def call
    fields_to_include = [:route_type, :city1, :city2, :route_claim]
    city_filter = { where_city_1: fields_to_include, where_city_2: fields_to_include }
    @all_routes = City.all.includes(city_filter).map do |city|
      city_details = { city: city }
      routes = city.where_city_1 + city.where_city_2
      city_details[:destinations] = routes.map { |route| Destination.new(route: route, city: city) }
      city_details
    end
  end
end