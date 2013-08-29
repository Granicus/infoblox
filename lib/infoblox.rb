require 'logger'
require 'json'
require 'faraday'
require 'faraday_middleware'
require 'openssl'
require 'infoblox/version'
require 'infoblox/connection'
require 'infoblox/resource'
require 'infoblox/client'
require 'infoblox/resource/cname'
require 'infoblox/resource/host'
require 'infoblox/resource/host_ipv4addr'
require 'infoblox/resource/ipv4addr'
require 'infoblox/resource/network'
require 'infoblox/resource/network_container'

module Infoblox
  WAPI_VERSION   = '1.0'
  BASE_PATH = '/wapi/v' + WAPI_VERSION + '/'
  DEBUG     = ENV['DEBUG']
end