module Infoblox
  class Fixedaddress < Resource
    remote_attr_accessor :name, :ipv4addr, :mac, :options

    WAPI_VERSION_OVERRIDE = '1.1'

    wapi_object "fixedaddress"
  end
end
