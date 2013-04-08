module ShipStationRuby
  class Client
    attr_accessor :auth, :service

    def initialize(username, password)
      raise ArgumentError unless username && password
      @auth = {:username => username, :password => password}

      @service = OData::Service.new("https://data.shipstation.com/1.1", @auth)
      self
    end

    def method_missing(method, *args, &block)
      method = method.to_s
      options = args.last.is_a?(Hash) ? args.pop : {}

      # method == 'orders'
      klass_symbol = method.singularize.camelize.to_sym
      # klass_symbol == :Orders
      ShipStationRuby.const_get(klass_symbol)
    end

    def inspect
      "#<ShipStationRuby::Client:#{object_id}>"
    end

  end
end