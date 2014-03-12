require 'logger'
require 'json'
require 'faraday'
require 'faraday_middleware'
require 'openssl'
require 'infoblox/version'
require 'infoblox/connection'
require 'infoblox/resource'

# Require everything in the resource directory
Dir[File.expand_path('../infoblox/resource/*.rb', __FILE__)].each do |f|
  require f
end

module Infoblox
  WAPI_VERSION   = '1.0'
  BASE_PATH = '/wapi/v' + WAPI_VERSION + '/'
  DEBUG     = ENV['DEBUG']
end