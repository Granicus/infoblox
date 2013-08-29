module Infoblox
  class Cname < Resource
    remote_attr_accessor :name, :canonical, 
                         :extensible_attributes
    attr_accessor :view

    wapi_object "record:cname"
  end
end