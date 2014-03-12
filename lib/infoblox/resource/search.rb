module Infoblox
  class Search < Resource
    wapi_object "search"

    # does not return objects not implemented in this library
    def self.find(connection,params)
      response = JSON.parse(connection.get(resource_uri,params).body)
      response.map do |jobj| 
        klass = resource_map[jobj["_ref"].split("/").first]
        if klass.nil?
          nil
        else
          klass.new(jobj.merge({:connection => connection}))
        end
      end.compact
    end
    
    # @private 
    def self.resource_map
      resource_classes = Infoblox.constants.map do |c|
                           Infoblox.const_get(c)
                         end.select do |c|
                           c.is_a?(Class) && c < Infoblox::Resource
                         end
      resource_map = Hash[ resource_classes.map { |c| [c.wapi_object,c] } ]
    end
  end
end
