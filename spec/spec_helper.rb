require_relative '../lib/shipstation_ruby'
 
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'turn'
 
Turn.config do |c|
  c.format  = :outline
  c.trace   = true
  c.natural = true
end
 
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/shipstation_ruby_cassettes'
  c.hook_into :webmock
end