module Infoblox
  class Search < Resource
    wapi_object "search"

    # does not return objects not implemented in this library
    def self.find(connection, params)
      JSON.parse(connection.get(resource_uri,params).body).map do |jobj|
        klass = resource_map[jobj["_ref"].split("/").first]
        if klass.nil?
          puts jobj['_ref']
          warn "umapped resource: #{jobj["_ref"]}"
        else
          klass.new(jobj.merge({:connection => connection}))
        end
      end.compact
    end
  end
end
