require "httparty"
require "hashie"
Dir[File.dirname(__FILE__) + '/shipstation_ruby/*.rb'].each do |file|
  require file
end

class Hashie::Mash
  
  # Converts all of the keys to strings, optionally formatting key name
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
  
end

#Taken from ActiveSupport, this code converts all camel cased seperated values to underscore seperated values. So OrderID becomes order_id.
class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

