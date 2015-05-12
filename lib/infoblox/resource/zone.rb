module Infoblox 
  class Zone < Resource
    attr_accessor :fqdn 
    remote_attr_accessor :address, :comment, :disable, :network_view, :extattrs
    
    wapi_object "zone"
  end
end
