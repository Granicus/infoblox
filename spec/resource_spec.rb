require 'spec_helper'
class FooResource < Infoblox::Resource
  remote_attr_accessor :name, :junction
  remote_attr_writer :do_it
  remote_post_accessor :sect

  attr_accessor :animal
  wapi_object "foo:animal"
end

FooResponse = Struct.new(:body)

class BarResource < Infoblox::Resource
  WAPI_VERSION_OVERRIDE = '3.14159'
  wapi_object "bar:pie"
end

describe Infoblox::Resource, "#add_ipv4addr" do
  it "hashes correctly" do
    host = FooResource.new
    host._ref = "123"
    host.animal = "mom"
    host.name = "lol"
    hsh = host.send(:remote_attribute_hash)
    hsh.should eq({:name => 'lol'})
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
    FooResource.all(conn).should eq([])
  end

  it "should allow .all with return fields or max results" do
    conn = double
    uri = Infoblox::BASE_PATH + "foo:animal"
    allow(conn).to receive(:get).with(uri, {:_return_fields => "name,junction", :_max_results => -70}).and_return(FooResponse.new("[]"))
    FooResource.all(conn, :_max_results => -70).should eq([])
  end

  it "should put with the right attributes" do
    conn = double
    uri = Infoblox::BASE_PATH + "abcd"
    allow(conn).to receive(:put).with(uri, {:name => "jerry", :junction => "32", :do_it => false}).and_return(FooResponse.new("\"foobar\""))
    f = FooResource.new(:connection => conn)
    f._ref = "abcd" 
    f.do_it = false
    f.junction = "32"
    f.name = "jerry"
    f.sect = :fulburns
    f.put
    f._ref.should eq("foobar")
  end

  it "should post with the right attributes" do
    conn = double
    uri = Infoblox::BASE_PATH + "foo:animal"
    allow(conn).to receive(:post).with(uri, {:name => "jerry", :junction => "32", :do_it => false, :sect => :fulburns}).and_return(FooResponse.new("\"abcdefg\""))
    f = FooResource.new(:connection => conn)
    f.do_it = false
    f.junction = "32"
    f.name = "jerry"
    f.sect = :fulburns
    f.post
    f._ref.should eq('abcdefg')
  end

  it 'should map wapi objects to classes' do
    @expected = {}
    ObjectSpace.each_object(Class) do |p|
      if p < Infoblox::Resource
        @expected[p.wapi_object] = p
      end
    end
    Infoblox::Resource.resource_map.should eq(@expected)
  end

  it 'respects overridden WAPI version strings' do
    conn = double
    b = BarResource.new(connection: conn)
    expect(b.resource_uri).to eq '/wapi/v3.14159/bar:pie'
  end
end

