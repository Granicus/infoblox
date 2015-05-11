module Infoblox
  class Range < Resource
    remote_attr_accessor :start_addr, :end_addr, :network_view, :extattrs

    wapi_object "range"
    
    ## 
    # Invoke the same-named function on the range resource in WAPI, 
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