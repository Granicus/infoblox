module Infoblox
  class Cname < Resource
    remote_attr_accessor :name, :canonical, 
                         :extensible_attributes, :view

    wapi_object "record:cname"
  end
end
