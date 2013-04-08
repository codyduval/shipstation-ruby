module ShipStationRuby
  class Carrier

    #client.carriers.find(12345)
    #Returns a single order in a Mash object
    def self.find(client,id)
      client.Carriers(id)
      result = client.execute
      single_result = result.first
      json_hash = JSON.parse(single_result.to_json)
      #convert Hash into Mash for easy method-like access
      json_mash = Hashie::Mash.new(json_hash)
      #convert CamelCase attributes into snake_case
      return json_mash.rubyify_keys!
    end

    #client.carriers.all
    #returns all carriers in an array of Hashie::Mash objects
    #TODO - add pagination
    def self.all(client)
      client.Carriers()
      results = client.execute
      formatted_results = []
      results.each do |result|
        result_hash = JSON.parse(result.to_json)
        result_mash = Hashie::Mash.new(result_hash)
        formatted_results.push(result_mash.rubyify_keys!)
      end
      return formatted_results
    end

    #client.carriers.where("order_id"=>12345,"warehouse_id"=>987574)
    #returns an array of Hashie::Mash objects
    def self.where(client,filters={})
      final_string = ""
      final_string_array = []
      filters.each do |attribute, value|
        shipstation_style_attribute = attribute.to_s.classify.gsub(/Id/, 'ID')
        puts shipstation_style_attribute
        filter_string = "#{shipstation_style_attribute} eq #{value}"
        final_string_array << filter_string
      end
      final_string = final_string_array.join(' and ')
      client.Carriers.filter("#{final_string}")
      results = client.execute
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