module Infoblox
  class Host < Resource
    remote_attr_accessor :ipv4addrs, :name, :configure_for_dns
    attr_accessor :view

    wapi_object "record:host"

    def add_ipv4addr(address)
      @ipv4addrs ||= []
      @ipv4addrs << {:ipv4addr => address}
    end
  end
end