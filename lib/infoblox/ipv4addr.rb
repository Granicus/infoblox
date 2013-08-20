module Infoblox
  class Ipv4addr < Resource
    remote_attr_accessor :ipv4addr, :configure_for_dhcp
    attr_accessor :network, :host

    wapi_object "record:host_ipv4addr"
  end
end