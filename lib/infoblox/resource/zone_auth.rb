module Infoblox 
  class ZoneAuth < Resource
    attr_accessor :fqdn 
    
    remote_attr_accessor :comment, 
                         :disable, 
                         :extattrs
    
    remote_attr_reader :address,
                       :network_view

    wapi_object "zone_auth"
  end
end
