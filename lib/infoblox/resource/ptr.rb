module Infoblox
  class Ptr < Resource
    remote_attr_accessor :comment,
                         :disable,
                         :ipv4addr,
                         :ipv6addr,
                         :name, 
                         :ptrdname,
                         :extattrs,
                         :extensible_attributes,
                         :view, 
                         :zone

    wapi_object "record:ptr"
  end
end
