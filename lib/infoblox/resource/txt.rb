module Infoblox
  class Txt < Resource
    remote_attr_accessor :name, :text, 
                         :extensible_attributes, :view

    wapi_object "record:txt"
  end
end
