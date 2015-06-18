module Infoblox
  class Arecord < Resource
    remote_attr_accessor :comment,
                         :disable,
                         :extattrs,
                         :extensible_attributes,
                         :ipv4addr,
                         :name,
                         :ttl,
                         :view
                         
    remote_attr_reader :zone

    wapi_object "record:a"
  end
end
