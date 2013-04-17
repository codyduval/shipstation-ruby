require_relative '../../spec_helper'

describe 'HashieMash extensions' do
  it "must convert CamelCase keys to snake_case" do
    test_hash = {"TopLevel" => "Top level value"}
    
    test_rash = Hashie::Rash.new(test_hash)

    test_rash.must_equal({"top_level" => "Top level value"})
  end

  it "must convert nested CamelCase keys to snake_case" do
    test_hash = {"TopLevel" => {"SecondLevel" => {"ThirdLevel" => 9999 }}}
    
    test_rash = Hashie::Rash.new(test_hash)

    test_rash.must_equal({"top_level" => {"second_level" => {"third_level" => 9999 }}})
  end

end