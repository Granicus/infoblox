# An AAAA (address) record maps a domain name to an IPv6 address.
module Infoblox
  class AAAArecord < Resource
    remote_attr_accessor :comment, 
                         :disable, 
                         :extattrs, 
                         :extensible_attributes,
                         :ipv6addr, 
                         :name, 
                         :ttl,
                         :use_ttl, 
                         :view
    
    remote_attr_reader :dns_name, 
                       :zone

    wapi_object "record:aaaa"
  end
end
