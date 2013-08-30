module Infoblox
  class Client
    ##
    # :username
    # :password
    # :host (host if infoblox appliance, including protocol)
    def initialize(options={})
      self.connection = Connection.new(options)
    end

    def all_hosts
      Host.all(connection)
    end

    ## 
    # Find all host records by wildcard name. 
    # 
    def find_host_by_name(name)
      Host.find(connection, :"name~" => name)
    end

    ##
    # Find all ipv4addr records by ip address fragment.
    # ex:  find_ips('10.10.2') => [#<Infoblox::Ipv4addr>...]
    #
    def find_ips(ip_fragment)
      Ipv4addr.find(connection, :"ipv4addr~" => ip_fragment)
    end

    ##
    # Create a host record for the given IP address
    # hostname : string
    # ip       : ipv4 string, i.e. "10.40.20.3"
    def create_host(hostname, ip, dns=true)
      host = Host.new(:name => hostname, :configure_for_dns => true, :connection => connection)
      host.add_ipv4addr(ip)
      host.create
    end

    ##
    # Remove all host entries for a given host
    #
    def delete_host(hostname)
      if !(hosts = Host.find(connection, :name => hostname)).empty?
        hosts.map(&:delete)
        hosts
      else
        raise Exception.new("host #{hostname} not found")
        false
      end
    end
  end
end