module Infoblox 
  class Network < Resource
    remote_attr_accessor :comment,
                         :extattrs,
                         :extensible_attributes, 
                         :network,
                         :network_view
    
    remote_attr_reader :network_container

    remote_post_accessor :auto_create_reversezone

    wapi_object "network"

    ## 
    # Invoke the same-named function on the network resource in WAPI, 
    # returning an array of available IP addresses. 
    # You may optionally specify how many IPs you want (num) and which ones to 
    # exclude from consideration (array of IPv4 address strings).
    #
    def next_available_ip(num=1, exclude=[])
      post_body = {
        :num =>     num.to_i,
        :exclude => exclude
      }
      JSON.parse(connection.post(resource_uri + "?_function=next_available_ip", post_body).body)["ips"]
    end
  end
end
