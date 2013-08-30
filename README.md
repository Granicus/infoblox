# Infoblox

Interact with the Infoblox WAPI with Ruby.  Use this gem to list, create, and delete host records. 

## Installation

Add this line to your application's Gemfile:

    gem 'infoblox'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install infoblox

## Command-line usage
The infoblox gem installs a command-line script called "infoblox," which supports
querying, adding, and removing host names from dns records: 

    infoblox --help


## Ruby client usage
The Client class has a few helper methods to make certain operations easier.  Creating a host record: 
  
    client = Infoblox::Client.new(:username => "foo", 
                                  :password => "bar", 
                                  :host => "https://foo-bar-dns.example.com")


    client.create_host("build-machine.internal", "10.10.3.3")
    client.delete_host("build-machine.internal")
    client.find_host_by_name("build-")

One can also use the resource classes directly to run arbitrary query logic.  An instance
of the Infoblox::Connection class is necessary:

    connection = Infoblox::Connection.new(:username => '', :password => '', :host => '')

    Infoblox::Network.find(connection, {"_return_fields" => "extensible_attributes"})
    # => [...]
   
    Infoblox::Host.find(connection, {"name~" => "demo[0-9]{1,}-web.domain"})
    # => [...]

The Resource sub-classes also support `get`, `post`, `put`, and `delete`.  For example, creating a network is pretty straightforward: 
 
    network = Infoblox::Network.new(:connection => connection)
    network.network = "10.20.30.0/24"
    network.extensible_attributes = {"VLAN" => "my_vlan"}
    network.auto_create_reversezone = true
    network.post # true

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
