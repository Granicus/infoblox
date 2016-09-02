module Infoblox
  class Ptr < Resource
    remote_attr_accessor :comment,
                         :disable,
                         :ipv4addr,
                         :ipv6addr,
                         :name, 
                         :ptrdname,
                         :ttl,
                         :extattrs,
                         :extensible_attributes,
                         :view
    
    def self._return_fields
      if Infoblox.wapi_version == '1.0'
        super.split(",").find_all{|f| f != 'ipv6addr'}.join(",")
      else
        super
      end
    end

    remote_attr_reader :zone

    wapi_object "record:ptr"
  end
end
