module Infoblox
  class Resource
    attr_accessor :_ref, :connection

    def self.wapi_object(obj=nil)
      obj.nil? ? @wapi_object : @wapi_object = obj
    end

    ## 
    # Define a writeable remote attribute, i.e. one that 
    # should show up in post / put operations.
    # 
    def self.remote_attr_accessor(*args)
      args.each do |a|
        attr_accessor a
        remote_attrs << a
      end
    end

    ##
    # Define a remote attribute that can only be sent during a
    # POST operation. 
    # 
    def self.remote_post_accessor(*args)
      args.each do |a|
        attr_accessor a
        remote_post_attrs << a
      end
    end

    ##
    # Define a remote attribute that is write-only
    # 
    def self.remote_attr_writer(*args)
      args.each do |a|
        attr_accessor a
        remote_write_only_attrs << a
      end
    end

    def self.remote_attrs
      @remote_attrs ||= []
    end

    def self.remote_write_only_attrs
      @remote_write_only_attrs ||= []
    end

    def self.remote_post_attrs
      @remote_post_attrs ||= []
    end

    def self._return_fields
      self.remote_attrs.join(",")
    end

    def self.default_params
      {:_return_fields => self._return_fields}
    end

    ##
    # Return an array of all records for this resource. 
    #
    def self.all(connection)
      JSON.parse(connection.get(resource_uri, default_params).body).map do |item|
        new(item.merge({:connection => connection}))
      end
    end

    ##
    # Find resources with query parameters. 
    #
    # Example: return extensible attributes for every resource.
    #    {"_return_fields" => "extensible_attributes"}
    #
    # Example: filter resources by name.
    #    {"name~" => "foo.*bar"}
    #
    def self.find(connection, params)
      params = default_params.merge(params)
      JSON.parse(connection.get(resource_uri, params).body).map do |item|
        new(item.merge({:connection => connection}))
      end
    end

    def self.resource_uri
      BASE_PATH + self.wapi_object
    end

    def initialize(attrs={})
      attrs.each do |k,v|
        self.send("#{k}=", v)
      end
    end

    def post
      self._ref = unquote(connection.post(resource_uri, remote_attribute_hash(write = true, post = true)).body)
      true
    end
    alias_method :create, :post

    def delete
      connection.delete(resource_uri).status == 200
    end

    def get(params={})
      connection.get(resource_uri, params)
    end

    def put
      self._ref = unquote(connection.put(resource_uri, remote_attribute_hash(write = true)).body)
      true
    end

    def resource_uri
      self._ref.nil? ? self.class.resource_uri : (BASE_PATH + self._ref)
    end
    
    def remote_attribute_hash(write=false, post=false)
      {}.tap do |hsh|
        self.class.remote_attrs.each do |k|
          hsh[k] = self.send(k)
        end
        self.class.remote_write_only_attrs.each do |k|
          hsh[k] = self.send(k)
        end if write
        self.class.remote_post_attrs.each do |k|
          hsh[k] = self.send(k)
        end if post
      end
    end

  private
    def unquote(str)
      str.gsub(/\A['"]+|['"]+\Z/, "")
    end
  end

end