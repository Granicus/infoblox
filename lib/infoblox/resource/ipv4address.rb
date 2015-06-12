module Infoblox
  class Ipv4address < Resource
    remote_attr_reader :dhcp_client_identifier, 
                       :ip_address, 
                       :is_conflict, 
                       :lease_state, 
                       :mac_address, 
                       :names, 
                       :network, 
                       :network_view, 
                       :objects, 
                       :status, 
                       :types, 
                       :usage, 
                       :username
    
    remote_attr_accessor :extattrs, :extensible_attributes

    wapi_object "ipv4address"

    def delete
      raise "Not supported"
    end
    
    def create
      raise "Not supported"
    end

    def modify
      raise "Not supported"
    end
  end
end
