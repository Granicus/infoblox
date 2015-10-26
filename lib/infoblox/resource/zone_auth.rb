##
# ZoneAuth is only availabe in WAPI_VERSION >= 1.2
#
module Infoblox 
  class ZoneAuth < Resource
    remote_attr_accessor :comment, 
                         :disable, 
                         :extattrs

    remote_post_accessor :fqdn

    remote_attr_reader :address,
                       :network_view

    wapi_object "zone_auth"
  end
end
