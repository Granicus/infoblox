module Infoblox
  class Host < Resource
    remote_attr_accessor :extattrs,
                         :extensible_attributes, 
                         :view, 
                         :aliases,
                         :configure_for_dns, 
                         :ipv4addrs, 
                         :name

    wapi_object "record:host"

    ##
    # The more robust way to add IP addresses to your host record, 
    # allowing you to set all the attributes. 
    #
    # Example: 
    # 
    #     host.ipv4addrs=[{:ipv4addr => '10.10.10.10', :mac => '0x0x0x0x0x0x0x'}]
    #
    def ipv4addrs=(attrs=[])
      attrs.each do |att|
        ipv4addrs << HostIpv4addr.new(att)
      end
    end

    ##
    # Add an IP address to this host.  Only allows setting the ipv4addr field
    # of the remote HostIpv4Addr record.  If you need to set other fields, 
    # such as mac or configure_for_dns, use #ipv4addrs=
    #
    def add_ipv4addr(address)
      ipv4addrs << HostIpv4addr.new(:ipv4addr => address)
    end

    def ipv4addrs
      @ipv4addrs ||= []
    end

    def remote_attribute_hash(write=false, post=false)
      super.tap do |hsh|
        hsh[:ipv4addrs] = ipv4addrs.map do |i|
          i.remote_attribute_hash(write, post).delete_if{|k,v| v.nil? }
        end
      end
    end
  end
end
