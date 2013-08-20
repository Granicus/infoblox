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
require 'infoblox/ipv4addr'
require 'infoblox/network'

module Infoblox
  WAPI_VERSION   = '1.0'
  BASE_PATH = '/wapi/v' + WAPI_VERSION + '/'
  DEBUG     = ENV['DEBUG']
end