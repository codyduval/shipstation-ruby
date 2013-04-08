require_relative '../../spec_helper'

describe 'HashieMash extensions' do

  describe 'rubyify_keys!' do
    it 'should make keys more rubylike' do
      hash = Hashie::Mash.new('Order' => 'foo')
      
      hash.rubyify_keys!

      hash.must_equal({'order' => 'foo'})
    end

    it 'should work recursively' do
      skip("TODO")
      hash = Hashie::Mash.new('Order' => {'OrderID' => 2000})
      
      hash.rubyify_keys!

      hash.must_equal({'order' => {'order_id' => 2000} })
    end
  end

  describe 'derubyify_keys!' do
    it 'should make keys more ShipStation-like' do
      hash = Hashie::Mash.new('order_id' => 2000)
      
      hash.derubyify_keys!

      hash.must_equal({'OrderID' => 2000})
    end

    it 'should work recursively' do
      skip("TODO")
      hash = Hashie::Mash.new('order' => {'order_id' => 2000})
      
      hash.derubyify_keys!

      hash.must_equal({'Order' => {'OrderID' => 2000} })
    end
  end
end