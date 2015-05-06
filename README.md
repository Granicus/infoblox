# Infoblox

Interact with the Infoblox WAPI with Ruby.  Use this gem to list, create, and delete host records. 

[![Build Status](https://travis-ci.org/govdelivery/infoblox.svg?branch=master)](https://travis-ci.org/govdelivery/infoblox)
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

    connection = Infoblox::Connection.new(username: '', password: '', host: '')

## Reading
Each resource class implements `all` and `find`.  You can use the `_max_results` and `_return_fields` parameters for both of these methods. See the Infoblox WAPI documentation on how to use these parameters. 

    # Find all networks. Note that this is limited to 1000 objects, as per the 
    # Infoblox WAPI documentation. 
    Infoblox::Network.all(connection)
    # => [...]
    
    # If you want more than 1,000 records, use `_max_results`:
    Infoblox::Network.all(connection, _max_results: 7890)
   
    # You can find hosts that match a regular expression:
    Infoblox::Host.find(connection, {"name~" => "demo[0-9]{1,}-web.domain"})
    # => [...]

The usage of search parameters is well-documented in the Infoblox WAPI documentation, and this client supports them fully.

## Searching
You can also search across the Infoblox cluster using the `Infoblox::Search` resource. The response will contain any number of `Infoblox::Resource` subclass instances. 

    result = Infoblox::Search.find(connection, "search_string~" => "webserver-")
    # => [#<Infoblox::Host>, #<Infoblox::Ptr>, ...]
    
## Writing and deleting
The resource class instances implement `get`, `post`, `put`, and `delete` methods, which correspond to the REST verbs supported by the WAPI.  For example, here is how to create, update, and delete a network:
 
    # create
    network = Infoblox::Network.new(connection: connection)
    network.network = "10.20.30.0/24"
    network.extensible_attributes = {"VLAN" => "my_vlan"}
    network.auto_create_reversezone = true
    network.post

    # update
    network.network = "10.20.31.0/24"
    network.put

    # delete
    network.delete

This pattern applies for interacting with every resource.  Supported resources include:
    
    Infoblox::Arecord
    Infoblox::Cname
    Infoblox::FixedAddress
    Infoblox::Host
    Infoblox::HostIpv4addr
    Infoblox::Ipv4address
    Infoblox::Mx
    Infoblox::Network
    Infoblox::NetworkContainer
    Infoblox::Ptr
    Infoblox::Search
    Infoblox::Srv
    Infoblox::Txt

The specific attributes supported by each resource are listed in the source code.

## Changing IP on an existing host
To change the IP of an existing host, you have to poke around in the ipv4addrs collection to find the one you are looking for.  The example below assumes that there is only one ipv4 address and just overwrites it. 

    host = Infoblox::Host.find(connection, {"name~" => "my.host.name"}).first
    host.ipv4addrs[0].ipv4addr = "10.10.10.10"
    host.put

## Basic CRUD examples

To do basic create/update/delete operations on an a_record/ptr_record set:

Create:

    a_record = Infoblox::Arecord.new(
      connection: connection, 
      name:       <fqdn>, 
      ipv4addr:   <ip_address>)
    a_record.post
    
    ptr_record = Infoblox::Ptr.new(
      connection: connection, 
      ptrdname:   <fqdn>, 
      ipv4addr:   <ip_address>)
    ptr_record.post

Update:

    a_record = Infoblox::Arecord.find(connection, {
      name:     <fqdn>, 
      ipv4addr: <ip_address>
    }).first
    a_record.name     = <fqdn>
    a_record.ipv4addr = <ip_address>
    a_record.view     = nil
    a_record.put

    ptr_record = Infoblox::Ptr.find(connection, {
      ptrdname: <fqdn>, 
      ipv4addr: <ip_address>
    }).first

    ptr_record.ptrdname = <fqdn>
    ptr_record.ipv4addr = <ip_address>
    ptr_record.view = nil
    ptr_record.put

Delete:

    a_record = Infoblox::Arecord.find(connection, {
      name:     <fqdn>, 
      ipv4addr: <ip_address>
    }).first
    a_record.delete
    
    ptr_record = Infoblox::Ptr.find(connection, {
      ptrdname: <fqdn>, 
      ipv4addr: <ip_address>
    }).first
    ptr_record.delete

## Next Available IP

The `Infoblox::Network` object supports the `next_available_ip` WAPI function: 

    network    = Infoblox::Network.find(connection, 
                                   network: '10.21.0.0/24').first
    puts network.next_available_ip.inspect
    #=> ["10.21.0.22"]

Note that this function does not work on a `Network` that has not been created.  In other words, if you want to get the next available IP for a given network segment, you have to create that segment beforehand.  See the CRUD examples above. 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
