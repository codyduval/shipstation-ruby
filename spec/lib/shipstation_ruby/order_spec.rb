require_relative '../../spec_helper'

describe ShipStationRuby::Order do
   
  describe "default attributes" do
    it "must have a username and password" do
      order_test = ShipStationRuby::Order.new("username","password")
      order_test.auth[:username].must_equal "username"
      order_test.auth[:password].must_equal "password"
    end
  end

  describe "GET order" do
    let(:order_test) { ShipStationRuby::Order.new("codyduval","coffee_bean") }

    it "must get the right Order from the OData service" do
      order_test.order(21660574).order_id.must_equal 21660574
    end

    it "must return a Mash object" do
      order_test.order(21660574).must_be_instance_of Hashie::Mash
    end
  end

  describe "GET orders" do
    let(:order_test) { ShipStationRuby::Order.new("codyduval","coffee_bean") }

    it "must return an array of Mash objects with the results" do
      order_test.orders.must_be_instance_of Array
    end
  end

  describe "GET filtered order" do
    let(:order_test) { ShipStationRuby::Order.new("codyduval","coffee_bean") }

    it "must get the correct filtered result with one parameter" do
      order_test.filter(:CustomerID => 15843013).first.order_id.must_equal 21660574
    end

    it "must return an array of Mash objects with the results" do
      order_test.filter(:OrderID => 21660574, :SellerID => 105162).first.order_id.must_equal 21660574
    end
  end


end

