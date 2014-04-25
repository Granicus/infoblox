module Infoblox
  class Arecord < Resource
    remote_attr_accessor :name, :ipv4addr, :ttl,
                         :extensible_attributes, :view

    wapi_object "record:a"
  end
end
