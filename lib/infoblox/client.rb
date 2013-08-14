module Infoblox
  class Client
    ##
    # :username
    # :password
    # :host (host if infoblox appliance, including protocol)
    def initialize(options={})
      Resource.connection = Connection.new(options)
    end

    def all_hosts
      Host.all
    end

    def find_host_by_name(name)
      Host.find(:"name~" => name)
    end

    ##
    # hostname : string
    # ip       : ipv4 string, i.e. "10.40.20.3"
    def create_host(hostname, ip, dns=true)
      host = Host.new(:name => hostname, :configure_for_dns => true)
      host.add_ipv4addr(ip)
      host.create
    end

    def delete_host(hostname)
      if !(hosts = Host.find(:name => hostname)).empty?
        hosts.map(&:delete)
        hosts
      else
        raise Exception.new("host #{hostname} not found")
        false
      end
    end
  end
end