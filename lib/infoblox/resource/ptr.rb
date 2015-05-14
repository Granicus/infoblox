module Infoblox
  class Ptr < Resource
    remote_attr_accessor :ipv4addr, :name, :ptrdname, 
                         :extensible_attributes, :view, :extattrs # keeping both formats of extensible attributes to support all WAPI versions

    wapi_object "record:ptr"
  end
end
