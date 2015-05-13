module Infoblox
  class Arecord < Resource
    remote_attr_accessor :name, :ipv4addr, :ttl,
                         :extensible_attributes, :view, :extattrs # keeping both formats of extensible attributes to support all WAPI versions

    wapi_object "record:a"
  end
end
