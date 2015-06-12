module Infoblox
  class HostIpv4addr < Resource
    remote_attr_accessor :configure_for_dhcp, 
                         :ipv4addr, 
                         :mac,
                         :network,
                         :nextserver,
                         :use_nextserver,
                         :bootfile,
                         :use_bootfile
                         
    remote_post_accessor :host
    
    wapi_object "record:host_ipv4addr"

    def delete
      raise "Not supported"
    end
  end
end
