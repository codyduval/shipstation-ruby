require_relative '../../spec_helper'

describe ShipStationRuby::Order do

  describe "GET order" do
    let(:order_test) { ShipStationRuby::Order.new("codyduval","coffee_bean") }

    it "must get the right Order from the OData service" do
      VCR.use_cassette('get_order') do
        order_test.order(21660574).order_id.must_equal 21660574
      end
    end

    it "must return a Mash object" do
      VCR.use_cassette('get_order') do
        order_test.order(21660574).must_be_instance_of Hashie::Mash
      end
    end
  end

  describe "GET orders" do
    let(:order_test) { ShipStationRuby::Order.new("codyduval","coffee_bean") }

    it "must return an array of Mash objects with the results" do
      VCR.use_cassette('get_orders') do
        order_test.orders.must_be_instance_of Array
      end
    end
  end

  describe "GET filtered order" do
    let(:order_test) { ShipStationRuby::Order.new("codyduval","coffee_bean") }

    it "must get the correct filtered result with one parameter" do
      VCR.use_cassette('filtered_order_one_param') do
        order = order_test.filter(:CustomerID => 15843013).first
        order.order_id.must_equal 21660574
      end
    end

    it "must return an array of Mash objects with the results" do
      VCR.use_cassette('filtered_order_two_params') do
        order = order_test.filter(:OrderID => 21660574, :SellerID => 105162).first
        order.order_id.must_equal 21660574
      end
    end
  end


end

