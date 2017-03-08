module Infoblox
  # minimum WAPI version: 1.1
  class RoamingHost < Resource
    remote_attr_accessor :extattrs,
                         :mac,
                         :bootfile,
                         :use_bootfile,
                         :nextserver,
                         :use_nextserver,
                         :name,
                         :network_view,
                         :options,
                         :match_client,
                         :comment

    wapi_object 'roaminghost'
  end
end
