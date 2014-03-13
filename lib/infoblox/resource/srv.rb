module Infoblox
  class Srv < Resource
    remote_attr_accessor :name, :port, :priority, :target, :weight, 
                         :extensible_attributes, :view

    wapi_object "record:srv"
  end
end
