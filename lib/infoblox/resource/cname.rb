module Infoblox
  class Cname < Resource
    remote_attr_accessor :canonical, 
                         :comment,
                         :extattrs,
                         :extensible_attributes, 
                         :name, 
                         :view

    wapi_object "record:cname"
  end
end
