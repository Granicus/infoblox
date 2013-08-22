require 'spec_helper'
class FooResource < Infoblox::Resource
  remote_attr_accessor :name, :junction
  attr_accessor :animal
  wapi_object "foo:animal"
end

FooResponse = Struct.new(:body)

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

  it "should find with default attributes" do
    conn = double
    uri = Infoblox::BASE_PATH + "foo:animal"
    allow(conn).to receive(:get).with(uri, {:_return_fields => "name,junction"}).and_return(FooResponse.new("[]"))
    FooResource.connection = conn
    FooResource.all.should eq([])
  end
end

