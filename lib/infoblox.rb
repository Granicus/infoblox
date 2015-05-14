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
  DEBUG        = ENV['DEBUG']
  
  def wapi_version
    @wapi_version ||= (ENV['WAPI_VERSION'] || '1.0')
  end
  module_function :wapi_version

  def wapi_version=(v)
    @wapi_version = v
  end
  module_function :wapi_version=
  
  def base_path    
    '/wapi/v' + Infoblox.wapi_version + '/'
  end
  module_function :base_path
end
