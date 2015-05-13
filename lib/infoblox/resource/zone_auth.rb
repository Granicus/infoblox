module Infoblox 
  class ZoneAuth < Resource
    attr_accessor :fqdn 
    remote_attr_accessor :address, :comment, :disable, :network_view, :extattrs
    
    wapi_object "zone_auth"
  end
end
