# Infoblox

Interact with the Infoblox WAPI with Ruby.  Use this gem to list, create, and delete host records. 

## Installation

Add this line to your application's Gemfile:

    gem 'infoblox'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install infoblox

# Usage

## Connecting
An instance of the `Infoblox::Connection` class is necessary:

    connection = Infoblox::Connection.new(:username => '', :password => '', :host => '')

## Querying
Once a connection is made, one can use the resource class methods to query records: 

    Infoblox::Network.all(connection)
    # => [...]
   
    Infoblox::Host.find(connection, {"name~" => "demo[0-9]{1,}-web.domain"})
    # => [...]

You can also search across the Infoblox cluster using the `Infoblox::Search` resource. The response will contain any number of `Infoblox::Resource` subclass instances. 

    result = Infoblox::Search.find(connection, "search_string~" => "webserver-")
    # => [#<Infoblox::Host>, #<Infoblox::Ptr>, ...]
    
## Creating, updating, and deleting resources
The resource class instances support `get`, `post`, `put`, and `delete`.  For example, creating a network is pretty straightforward: 
 
    network = Infoblox::Network.new(:connection => connection)
    network.network = "10.20.30.0/24"
    network.extensible_attributes = {"VLAN" => "my_vlan"}
    network.auto_create_reversezone = true
    network.post # true
    network.network = "10.20.31.0/24"
    network.put  # true


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
