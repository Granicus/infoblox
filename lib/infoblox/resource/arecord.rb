module Infoblox
  class Arecord < Resource
    remote_attr_accessor :extattrs,
                         :extensible_attributes, 
                         :ipv4addr, 
                         :ttl,
                         :view, 
                         :name

    wapi_object "record:a"
  end
end
