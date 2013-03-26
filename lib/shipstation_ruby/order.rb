module ShipStationRuby
  class Order
    include HTTParty
    base_uri 'https://data.shipstation.com/1.1'
    format :json
    headers 'Accept' => 'application/json'

    attr_accessor :auth, :order_id    

    def initialize(u, p, order_id)
      @auth = {:username => u, :password => p}
      self.order_id = order_id
    end

    def details(force = false)
      force ? @details = get_details : @details ||= get_details
    end

    private

    def get_details
      details = Hashie::Mash.new(self.class.get("/Orders(#{self.order_id})", :basic_auth => self.auth))
      # the ShipStation json arrives with all data as a subhash of the key ":d", so this deletes that key and pulls the rest of the attributes up a level
      details = details.merge(details.delete(:d))
      details.rubyify_keys!
    end


  end
end