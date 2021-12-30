# frozen_string_literal: true

module Infoblox
  # Error class
  class Error < StandardError
  end

  # Connection class
  class Connection
    attr_accessor :adapter,
                  :adapter_block,
                  :connection,
                  :host,
                  :logger,
                  :password,
                  :ssl_opts,
                  :username,
                  :timeout

    def get(href, params = {})
      wrap do
        connection.get(href, params)
      end
    end

    def post(href, body)
      wrap do
        connection.post do |req|
          req.url href
          req.body = body.to_json
        end
      end
    end

    def put(href, body)
      wrap do
        connection.put do |req|
          req.url href
          req.body = body.to_json
        end
      end
    end

    def delete(href)
      wrap do
        connection.delete(href)
      end
    end

    def initialize(opts = {})
      self.username = opts[:username]
      self.password = opts[:password]
      self.host     = opts[:host]
      self.logger   = opts[:logger]
      self.ssl_opts = opts[:ssl_opts] || {}
      self.timeout  = opts[:timeout] || 60
    end

    def connection
      @connection = Faraday.new(request: { timeout: timeout,
                                           open_timeout: timeout },
                                url: host,
                                ssl: ssl_opts) do |builder|
        builder.request :basic_auth, username, password
        builder.response :logger, logger if logger
        builder.request :json
        builder.adapter adapter, &adapter_block
      end
    end

    ##
    # The host variable is expected to be a protocol with a host name.
    # If the host has no protocol, https:// is added before it.
    #
    def host=(new_host)
      new_host = "https://#{new_host}" unless new_host =~ %r{/^http(s)?:///}
      @host = new_host
    end

    def adapter
      @adapter ||= :net_http
    end

    ##
    # Don't display the username/password in logging, etc.
    #
    def inspect
      "#<#{self.class}:#{object_id} @host=\"#{@host}\">"
    end

    private

    def wrap
      yield.tap do |response|
        raise Infoblox::Error.new "Error: #{response.status} #{response.body}" unless response.status < 300
      end
    end
  end
end
