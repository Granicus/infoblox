module Infoblox
  class HostIpv4addr < Resource
    remote_attr_accessor :network, :host, :ipv4addr, :configure_for_dhcp, :mac
    
    wapi_object "record:host_ipv4addr"

    def delete
      raise "Not supported"
    end
  end
end
