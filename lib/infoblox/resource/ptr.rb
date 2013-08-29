module Infoblox
  class Ptr < Resource
    remote_attr_accessor :ipv4addr, :name, :ptrdname, 
                         :extensible_attributes
    attr_accessor :view

    wapi_object "record:ptr"
  end
end