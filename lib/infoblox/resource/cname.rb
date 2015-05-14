module Infoblox
  class Cname < Resource
    remote_attr_accessor :name, :canonical, :comment,
                         :extensible_attributes, :view, :extattrs # keeping both formats of extensible attributes to support all WAPI versions

    wapi_object "record:cname"
  end
end
