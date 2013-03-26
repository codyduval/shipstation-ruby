require_relative '../../spec_helper'
 
describe ShipStationRuby::Order do
   
  describe "default attributes" do

    it "must include httparty methods" do
      ShipStationRuby::Order.must_include HTTParty
    end
 
    it "must have the base url set to the ShipStation API endpoint" do
      ShipStationRuby::Order.base_uri.must_equal 'https://data.shipstation.com/1.1'
    end

    it "must have a username and password and order_id" do
      order = ShipStationRuby::Order.new("username","password", "12345")
      order.auth[:username].must_equal "username"
      order.auth[:password].must_equal "password"
      order.order_id.must_equal "12345"
    end
  end

  describe "default instance attributes" do

    let(:order) { ShipStationRuby::Order.new("codyduval","coffee_bean", 21660574) }

    it "must have an order_id attribute" do
      order.must_respond_to :order_id
    end

    it "must have the right id" do
      order.order_id.must_equal 21660574
    end

  end

  describe "GET order" do

    let(:order) { ShipStationRuby::Order.new("codyduval","coffee_bean", 21660574) }

    before do
      VCR.insert_cassette 'order', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it "records the fixture" do
      ShipStationRuby::Order.get('/Orders(21660574)', :basic_auth => {:username => "codyduval", :password => "coffee_bean"})
    end

    it "must have a details method" do
      order.must_respond_to :details
    end
   
    it "must parse the api response from JSON to Hashie" do
      order.details.must_be_instance_of Hashie::Mash
    end
   
    it "must get the right Order" do
      order.details.order_id.must_equal 21660574
    end

    it "must show a store_id" do
      order.details.store_id.must_equal 20979
    end

    it "must respond to a random attribute like WarehouseID (but as warehouse_id)" do
      order.details.must_respond_to :warehouse_id
    end

    it "must not respond to an attribute that is not present in json" do
      order.details.wont_respond_to :foo_bar_attribute
    end

  end
end

