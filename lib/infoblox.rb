require 'logger'
require 'json'
require 'faraday'
require 'faraday_middleware'
require 'openssl'
require 'infoblox/version'
require 'infoblox/connection'
require 'infoblox/resource'
require 'infoblox/host'
require 'infoblox/client'

module Infoblox
  VERSION   = '1.0'
  BASE_PATH = '/wapi/v' + VERSION + '/'
  DEBUG     = ENV['DEBUG']
end

#OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE