module Infoblox 
  class Network < Resource
    remote_attr_accessor :network, :extensible_attributes, :extattrs # keeping both formats of extensible attributes to support all WAPI versions
    remote_post_accessor :auto_create_reversezone
    
    attr_accessor :network_view, :network_container

    wapi_object "network"

    ## 
    # Invoke the same-named function on the network resource in WAPI, 
    # returning an array of available IP addresses. 
    # You may optionally specify how many IPs you want (num) and which ones to 
    # exclude from consideration (array of IPv4 addrdess strings).
    #
    def next_available_ip(num=1, exclude=[])
      post_body = {
        num:     num.to_i,
        exclude: exclude
      }
      JSON.parse(connection.post(resource_uri + "?_function=next_available_ip", post_body).body)["ips"]
    end
  end
end
