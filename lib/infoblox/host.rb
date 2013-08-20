module Infoblox
  class Host < Resource
    remote_attr_accessor :ipv4addrs, :name, :configure_for_dns
    attr_accessor :view

    wapi_object "record:host"

    def ipv4addrs=(attrs=[])
      attrs.each do |att|
        ipv4addrs << Ipv4addr.new(att)
      end
    end

    def add_ipv4addr(address)
      ipv4addrs << Ipv4addr.new(:ipv4addr => address)
    end

    def ipv4addrs
      @ipv4addrs ||= []
    end
  end
end