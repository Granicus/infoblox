module Infoblox
  class Ptr < Resource
    remote_attr_accessor :comment,
                         :disable,
                         :ipv4addr,
                         :ipv6addr,
                         :name, 
                         :ptrdname,
                         :ttl,
                         :extattrs,
                         :extensible_attributes,
                         :view
    
    remote_attr_reader :zone

    wapi_object "record:ptr"
  end
end
