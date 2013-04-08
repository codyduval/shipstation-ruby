module ShipStationRuby
  class Collection

    attr_accessor :client, :resource

    def initialize(client, resource)
      @client = client
      @resource = resource
    end

    def find(id)
      @resource.find(@client, id)
    end

    def all
      @resource.all(@client)
    end

    def self.all(client)
      client.Orders()
      results = client.execute
      formatted_results = []
      results.each do |result|
        result_hash = JSON.parse(result.to_json)
        result_mash = Hashie::Mash.new(result_hash)
        formatted_results.push(result_mash.rubyify_keys!)
      end
      return formatted_results
    end

    def where(filters={})
      @resource.where(@client, filters)
    end

    def fields
      @resource.fields(@client)
    end

  end
end
