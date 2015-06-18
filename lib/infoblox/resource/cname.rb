module Infoblox
  class Cname < Resource
    remote_attr_accessor :canonical, 
                         :comment,
                         :disable,
                         :extattrs,
                         :extensible_attributes, 
                         :name, 
                         :view
    
    remote_attr_reader :zone


    wapi_object "record:cname"
  end
end
