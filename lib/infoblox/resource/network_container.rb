module Infoblox
  class NetworkContainer < Resource
    remote_attr_accessor :network, :extensible_attributes, :extattrs # keeping both formats of extensible attributes to support all WAPI versions
    remote_post_accessor :auto_create_reversezone
    
    attr_accessor :network_view

    wapi_object "networkcontainer"
  end
end 