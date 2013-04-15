module ShipStationRuby
  class Collection

    attr_accessor :client, :resource

    def initialize(client, resource)
      @client = client
      @resource = resource
    end

    def find(id)
      @client.send("#{@resource}",id)
      result = @client.execute
      single_result = result.first
      json_hash = JSON.parse(single_result.to_json)
      json_rash = Hashie::Rash.new(json_hash)
      return json_rash
    end

    def all
      @client.send("#{@resource}")
      results = @client.execute
      formatted_results = []
      results.each do |result|
        result_hash = JSON.parse(result.to_json)
        result_rash = Hashie::Rash.new(result_hash)
        formatted_results.push(result_rash)
      end
      return formatted_results
    end

    def where(filters={})
      final_string = ""
      final_string_array = []
      filters.each do |attribute, value|
        shipstation_style_attribute = attribute.to_s.classify.gsub(/Id/, 'ID')
        puts shipstation_style_attribute
        puts value
        if value.is_a?(Integer)
          filter_string = "#{shipstation_style_attribute} eq #{value}"
        else
          filter_string = "#{shipstation_style_attribute} eq '#{value}'"
        end

        final_string_array << filter_string
      end
      final_string = final_string_array.join(' and ')
      puts final_string
      @client.send("#{@resource}").filter("#{final_string}")
      results = @client.execute
      formatted_results = []
      results.each do |result|
        result_hash = JSON.parse(result.to_json)
        result_rash = Hashie::Rash.new(result_hash)
        formatted_results.push(result_rash)
      end
      return formatted_results
    end


    def fields
      @resource.fields(@client)
    end

  end
end
