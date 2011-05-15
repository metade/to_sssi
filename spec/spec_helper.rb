dir = File.dirname(__FILE__)
$LOAD_PATH.unshift "#{dir}/../lib"

ROOT = File.dirname(__FILE__) + '/..'

require 'rubygems'
require 'rspec'
require 'to_sssi'

RSpec.configure do |config|
  config.mock_with :mocha
end
