module Infoblox
  class Arecord < Resource
    remote_attr_accessor :name, 
                         :extensible_attributes
    remote_attr_accessor :ipv4addr
    attr_accessor :view

    wapi_object "record:a"
  end
end