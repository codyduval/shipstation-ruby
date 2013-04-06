require_relative '../../spec_helper'

describe ShipStationRuby::Client do
  it "sets authentication on initialize" do
    order_test = VCR.use_cassette('get_metadata') do
      ShipStationRuby::Client.new("codyduval","coffee_bean")
    end
    order_test.auth[:username].must_equal "codyduval"
    order_test.auth[:password].must_equal "coffee_bean"
  end

  it "must have a username and password" do
    proc { ShipStationRuby::Client.new("username", nil) }.must_raise ArgumentError
  end
end