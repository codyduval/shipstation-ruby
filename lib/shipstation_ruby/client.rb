module ShipStationRuby
  class Client
    attr_accessor :auth, :client

    def initialize(username, password)
      raise ArgumentError unless username && password
      @auth = {:username => username, :password => password}

      @client = OData::Service.new("https://data.shipstation.com/1.1", @auth)
      self
    end

    def method_missing(method, *args, &block)
      method = method.to_s
      options = args.last.is_a?(Hash) ? args.pop : {}

      # method == 'orders'
      klass_symbol = method.singularize.camelize.to_sym
      # klass_symbol == :Orders
      klass = ShipStationRuby.const_get(klass_symbol)
      ShipStationRuby::Collection.new(@client, klass)
      # ShipStationRuby::klass.new()
       # @resource_cache[method][options.hash] = ZendeskAPI::Collection.new(self, ZendeskAPI.const_get(ZendeskAPI::Helpers.modulize_string(Inflection.singular(method))), options)
    end

    def inspect
      "#<ShipStationRuby::Client:#{object_id}>"
    end

  end
end