module Infoblox
  class NetworkContainer < Resource
    remote_attr_accessor :network, :extensible_attributes
    remote_post_accessor :auto_create_reversezone
    
    attr_accessor :network_view

    wapi_object "networkcontainer"
  end
end 