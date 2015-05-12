# An AAAA (address) record maps a domain name to an IPv6 address.
module Infoblox
  class AAAArecord < Resource
    remote_attr_accessor :name, :ipv6addr, :ttl,
                         :extattr, :view, :comment, :disable, :dns_name, :use_ttl, :zone

    wapi_object "record:aaaa"
  end
end
