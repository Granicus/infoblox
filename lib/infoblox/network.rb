module Infoblox 
  class Network < Resource
    remote_attr_accessor :network, :extensible_attributes
    attr_accessor :network_view

    wapi_object "network"

    def next_available_ip(num=1)
      JSON.parse(connection.post(resource_uri + "?_function=next_available_ip&num=#{num}", {}).body)["ips"]
    end
  end
end