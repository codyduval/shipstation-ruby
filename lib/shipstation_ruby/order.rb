module ShipStationRuby
  class Order
    
    attr_accessor :auth   

    def initialize(username, password)
      @auth = {:username => username, :password => password}
    end

    #Returns one order in a Mash object
    def order(order_id)
      service = OData::Service.new("https://data.shipstation.com/1.1", @auth)
      service.Orders(order_id)
      result = service.execute
      order = result.first
      order = JSON.parse(order.to_json)
      #convert Hash into Mash for easy method-like access
      order = Hashie::Mash.new(order)
      #convert CamelCase attributes into snake_case
      @order = order.rubyify_keys!
    end

    #returns all orders in an Array (as Mash objects)
    def orders
      service = OData::Service.new("https://data.shipstation.com/1.1", @auth)
      service.Orders()
      results = service.execute
      formatted_results = []
      results.each do |result|
        result_hash = JSON.parse(result.to_json)
        result_mash = Hashie::Mash.new(result_hash)
        formatted_results.push(result_mash.rubyify_keys!)
      end
      return formatted_results
    end

    #Filters are added as parameters in the format :OrderID=>9999.  Multiple parameters will be submitted, and api will return result that matches all conditions
    def filter(filters={})
      final_string = ""
      final_string_array = []
      filters.each do |attribute, value|
        filter_string = "#{attribute} eq #{value}"
        final_string_array << filter_string
      end
      final_string = final_string_array.join(' and ')
      service = OData::Service.new("https://data.shipstation.com/1.1", @auth)
      service.Orders.filter("#{final_string}")
      results = service.execute
      formatted_results = []
      results.each do |result|
        result_hash = JSON.parse(result.to_json)
        result_mash = Hashie::Mash.new(result_hash)
        formatted_results.push(result_mash.rubyify_keys!)
      end
      return formatted_results
    end

  end
end
