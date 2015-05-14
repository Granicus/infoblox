module Infoblox
  class Srv < Resource
    remote_attr_accessor :extattrs, 
                         :extensible_attributes,
                         :name, 
                         :port, 
                         :priority, 
                         :target, 
                         :view,
                         :weight

    wapi_object "record:srv"
  end
end
