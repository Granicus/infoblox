module Infoblox
  class Host < Resource
    remote_attr_accessor :ipv4addrs, :name, :configure_for_dns, :aliases,
                         :extensible_attributes, :view

    wapi_object "record:host"

    def ipv4addrs=(attrs=[])
      attrs.each do |att|
        ipv4addrs << HostIpv4addr.new(att)
      end
    end

    def add_ipv4addr(address)
      ipv4addrs << HostIpv4addr.new(:ipv4addr => address)
    end

    def ipv4addrs
      @ipv4addrs ||= []
    end

    def remote_attribute_hash(write=false, post=false)
      super.tap do |hsh|
        hsh[:ipv4addrs] = ipv4addrs.map{|ipv4obj| Hash[ipv4obj.class.remote_attrs.map { |attrib| [attrib, ipv4obj.send(attrib)] unless ipv4obj.send(attrib).nil? }] }
      end
    end
  end
end
