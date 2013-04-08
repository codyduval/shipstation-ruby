require_relative '../../spec_helper'

describe "ShipStationRuby::Order metaclass" do

  describe "Find order" do
    let(:client) { ShipStationRuby::Client.new("codyduval","coffee_bean") }

    it "must find the right Order from the OData service" do
      VCR.use_cassette('find_order') do
        client.orders.find(21660574).order_id.must_equal 21660574
      end
    end

    it "must return a Mash object" do
      VCR.use_cassette('find_order') do
        client.orders.find(21660574).must_be_instance_of Hashie::Mash
      end
    end
  end

  describe "all orders" do
    let(:client) { ShipStationRuby::Client.new("codyduval","coffee_bean") }

    it "must return an array of Mash objects" do
      VCR.use_cassette('all_orders') do
        client.orders.all.must_be_instance_of Array
      end
    end
  end

  describe "GET filtered order" do
    let(:client) { ShipStationRuby::Client.new("codyduval","coffee_bean")  }

    it "must get the correct filtered result with one parameter" do
      VCR.use_cassette('filtered_order_one_param') do
        order = client.orders.where("customer_id"=> 15843013).first
        order.order_id.must_equal 21660574
      end
    end

    it "must get the correct filtered result with two passed parameters" do
      VCR.use_cassette('filtered_order_two_params') do
        order = client.orders.where("order_id" => 21660574, "seller_id" => 105162).first
        order.order_id.must_equal 21660574
      end
    end
  end


end

