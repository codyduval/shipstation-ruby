require_relative '../../spec_helper'

describe ShipStationRuby::Client do
  it "sets authentication on initialize with passed parameters" do
    client_test = VCR.use_cassette('get_metadata') do
      ShipStationRuby::Client.new
    end
    client_test.auth[:username].must_equal ShipStationRuby.username
    client_test.auth[:password].must_equal ShipStationRuby.password
  end

  it "must have a username and password" do
    proc { ShipStationRuby::Client.new("username", nil) }.must_raise ArgumentError
  end

end