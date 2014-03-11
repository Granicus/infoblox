module Infoblox
  class Mx < Resource
    remote_attr_accessor :mail_exchanger, :name, :preference,
                         :extensible_attributes, :view

    wapi_object "record:mx"
  end
end
