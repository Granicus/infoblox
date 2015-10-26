module Infoblox
  class Ptr < Resource
    remote_attr_accessor :comment,
                         :disable,
                         :ipv4addr,
                         :name, 
                         :ptrdname,
                         :extattrs,
                         :extensible_attributes,
                         :view

    remote_attr_accessor :ipv6addr if Infoblox::Resource.wapi_object.to_f >= 1.1
    
    remote_attr_reader :zone

    wapi_object "record:ptr"
  end
end
