require "httparty"
require "hashie"
require "json"
require "ruby_odata"

require "shipstation_ruby/client"
require "shipstation_ruby/collection"

class Hashie::Mash
  
  # Converts all of the keys to strings, optionally formatting key name
  # 'OrderID' => 'order_id'
  def rubyify_keys!
    keys.each{|k|
      v = delete(k)
      new_key = k.to_s.underscore
      self[new_key] = v
      v.rubyify_keys! if v.is_a?(Hash)
      v.each{|p| p.rubyify_keys! if p.is_a?(Hash)} if v.is_a?(Array)
    }
    self
  end

  # 'order_id' => 'OrderID'
  def derubyify_keys!
    keys.each{|k|
      v = delete(k)
      new_key = k.to_s.classify.gsub(/Id/, 'ID')
      self[new_key] = v
      v.derubyify_keys! if v.is_a?(Hash)
      v.each{|p| p.derubyify_keys! if p.is_a?(Hash)} if v.is_a?(Array)
    }
    self
  end
  
end
