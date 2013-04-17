module ShipStationRuby
  class Client
    attr_accessor :auth, :client

    def initialize(username = ShipStationRuby.username, password = ShipStationRuby.password)
      raise ArgumentError unless username && password
      @auth = {:username => username, :password => password}

      @client = OData::Service.new(API_BASE, @auth)
      self
    end

    def method_missing(method, *args, &block)
      method = method.to_s
      options = args.last.is_a?(Hash) ? args.pop : {}

      # method == 'orders'
      klass = method.pluralize.camelize
      ShipStationRuby::Collection.new(@client, klass)
    end

    def inspect
      "#<ShipStationRuby::Client:#{object_id}>"
    end

  end
end