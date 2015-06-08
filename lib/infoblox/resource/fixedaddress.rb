module Infoblox
  # minimum WAPI version: 1.1
  class Fixedaddress < Resource
    remote_attr_accessor :extattrs,
                         :ipv4addr, 
                         :mac, 
                         :name, 
                         :options,
                         :match_client

    wapi_object "fixedaddress"
  end
end
