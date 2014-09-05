module Infoblox
  class Cname < Resource
    remote_attr_accessor :name, :canonical, :comment,
                         :extensible_attributes, :view

    wapi_object "record:cname"
  end
end
