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
Create a new client: 
  
    client = Infoblox::Client.new(:username => "foo", 
                                  :password => "bar", 
                                  :host => "https://foo-bar-dns.example.com")

Creating a host record: 

    client.create_host("build-machine.internal", "10.10.3.3")
  
Delete the host: 
  
    client.delete_host("build-machine.internal")

Find hosts (fuzzy matches on host name): 

    client.find_host_by_name("build-")

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
