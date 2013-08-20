module Infoblox
  class Resource
    attr_accessor :_ref

    def self.wapi_object(obj=nil)
      obj.nil? ? @wapi_object : @wapi_object = obj
    end

    def self.remote_attr_accessor(*args)
      args.each do |a|
        attr_accessor a
        remote_attrs << a
      end
    end

    def self.remote_attrs
      @remote_attrs ||= []
    end

    def self.all
      JSON.parse(connection.get(resource_uri).body).map do |item|
        new(item)
      end
    end

    def self.find(params)
      JSON.parse(connection.get(resource_uri, params).body).map do |item|
        new(item)
      end
    end

    def self.connection
      @@connection
    end

    def self.connection=(con)
      @@connection = con
    end

    def self.resource_uri
      BASE_PATH + self.wapi_object
    end

    def initialize(attrs={})
      attrs.each do |k,v|
        self.send("#{k}=", v)
      end
    end

    def create
      self._ref = connection.post(resource_uri, remote_attribute_hash).body
      true
    end

    def delete
      connection.delete(resource_uri).status == 200
    end

    def get
      connection.get(resource_uri)
    end

    def resource_uri
      self._ref.nil? ? self.class.resource_uri : (BASE_PATH + self._ref)
    end
    
    def remote_attribute_hash
      {}.tap do |hsh|
        self.class.remote_attrs.each do |k|
          hsh[k] = self.send(k)
        end
      end
    end

  private

    def connection
      self.class.connection
    end

  end
end