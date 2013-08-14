require 'spec_helper'
class FooResource < Infoblox::Resource
  remote_attr_accessor :name, :junction
  attr_accessor :animal
  wapi_object "foo:animal"
end

describe Infoblox::Resource, "#add_ipv4addr" do
  it "hashes correctly" do
    host = FooResource.new
    host._ref = "123"
    host.animal = "mom"
    host.name = "lol"
    hsh = host.send(:remote_attribute_hash)
    hsh.should eq({:name => 'lol', :junction => nil})
  end

  it "should have a correct resource_uri" do
    FooResource.resource_uri.should eq(Infoblox::BASE_PATH + "foo:animal")
    f=FooResource.new
    f.resource_uri.should eq(Infoblox::BASE_PATH + "foo:animal")
    f._ref = "lkjlkj"
    f.resource_uri.should eq(Infoblox::BASE_PATH + "lkjlkj")
  end
end

