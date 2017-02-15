module Infoblox
  # NB: Only exists on WAPI 1.1 and up
  class Lease < Resource
    remote_attr_reader :address,
                       :binding_state,
                       :client_hostname,
                       :ends,
                       :hardware,
                       :network,
                       :network_view,
                       :protocol,
                       :starts

    wapi_object 'lease'
  end
end
