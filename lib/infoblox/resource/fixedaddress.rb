module Infoblox
  # minimum WAPI version: 1.1
  class Fixedaddress < Resource
    remote_attr_accessor :name, :ipv4addr, :mac, :options

    wapi_object "fixedaddress"
  end
end
