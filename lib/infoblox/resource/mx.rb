module Infoblox
  class Mx < Resource
    remote_attr_accessor :extattrs,
                         :extensible_attributes,
                         :mail_exchanger, 
                         :name, 
                         :preference,
                         :view

    wapi_object "record:mx"
  end
end
