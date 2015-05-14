module Infoblox
  class Ptr < Resource
    remote_attr_accessor :extattrs,
                         :extensible_attributes, 
                         :view, 
                         :ipv4addr, 
                         :name, 
                         :ptrdname 

    wapi_object "record:ptr"
  end
end
