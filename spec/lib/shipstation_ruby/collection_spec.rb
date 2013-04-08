require_relative '../../spec_helper'

describe ShipStationRuby::Collection do
  let(:client) { ShipStationRuby::Client.new("codyduval","coffee_bean") }

  it "initializes new Collection" do
    @resource = "orders"
    ShipStationRuby::Collection.new(@client, @resource).must_be_instance_of ShipStationRuby::Collection
  end

  describe "It must correctly find Order resource" do
    let(:client) { ShipStationRuby::Client.new("codyduval","coffee_bean") }

    it "must contain correct client and class" do
      @resource = "orders"
      collection = ShipStationRuby::Collection.new(@client, @resource)
      
      collection.client.must_equal @client
      collection.resource.must_equal "orders"
    end
  end

end