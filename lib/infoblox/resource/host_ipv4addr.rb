module Infoblox
  class HostIpv4addr < Resource
    remote_attr_accessor :network, :host, :ipv4addr
    
    wapi_object "record:host_ipv4addr"

    def post
      raise "Not supported"
    end

    def put
      raise "Not supported"
    end

    def delete
      raise "Not supported"
    end
  end
end