require_relative '../../spec_helper'

describe ShipStationRuby::Collection do
  let(:client) { ShipStationRuby::Client.new("codyduval","coffee_bean") }
  let(:resource) {ShipStationRuby::Order}

  it "initializes new Collection" do
    ShipStationRuby::Collection.new(@client, @resource).must_be_instance_of ShipStationRuby::Collection
  end

  it "must contain correct client and class" do
    collection = ShipStationRuby::Collection.new(@client, @resource)
    
    collection.client.must_equal @client
    collection.resource.must_equal @resource
  end

end