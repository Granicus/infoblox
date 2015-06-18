module Infoblox
  class NetworkContainer < Resource
    remote_attr_accessor :extattrs, 
                         :extensible_attributes, 
                         :network,
                         :network_view
                         
    remote_post_accessor :auto_create_reversezone
    
    remote_attr_reader :network_container

    wapi_object "networkcontainer"
  end
end 
