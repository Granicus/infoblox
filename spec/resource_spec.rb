require 'spec_helper'
class FooResource < Infoblox::Resource
  remote_attr_accessor :name, :junction, :extattrs, :extensible_attributes
  remote_attr_writer :do_it
  remote_post_accessor :sect
  remote_attr_reader :readonly_thing
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
    expect(hsh).to eq({:name => 'lol'})
  end  

  it "handles extattrs correctly in return fields" do
    expect(Infoblox).to receive(:wapi_version).and_return("1.0")
    hsh = FooResource._return_fields
    expect(hsh).to eq('name,junction,extensible_attributes,readonly_thing')

    expect(Infoblox).to receive(:wapi_version).and_return("1.2")
    hsh = FooResource._return_fields
    expect(hsh).to eq('name,junction,extattrs,readonly_thing')

    expect(Infoblox).to receive(:wapi_version).and_return("2.0")
    hsh = FooResource._return_fields
    expect(hsh).to eq('name,junction,extattrs,readonly_thing')
  end

  it "should have a correct resource_uri" do
    expect(FooResource.resource_uri).to eq(Infoblox.base_path + "foo:animal")
    f=FooResource.new
    expect(f.resource_uri).to eq(Infoblox.base_path + "foo:animal")
    f._ref = "lkjlkj"
    expect(f.resource_uri).to eq(Infoblox.base_path + "lkjlkj")
  end

  it "should find with default attributes" do
    conn = double
    uri = Infoblox.base_path + "foo:animal"
    allow(conn).to receive(:get).with(uri, {:_return_fields => "name,junction,extensible_attributes,readonly_thing"}).and_return(FooResponse.new("[]"))
    expect(FooResource.all(conn)).to eq([])
  end

  it "should allow .all with return fields or max results" do
    conn = double
    uri = Infoblox.base_path + "foo:animal"
    allow(conn).to receive(:get).with(uri, {:_return_fields => "name,junction,extensible_attributes,readonly_thing", :_max_results => -70}).and_return(FooResponse.new("[]"))
    expect(FooResource.all(conn, :_max_results => -70)).to eq([])
  end

  it "should put with the right attributes" do
    conn = double
    uri = Infoblox.base_path + "abcd"
    allow(conn).to receive(:put).with(uri, {:name => "jerry", :junction => "32", :do_it => false}).and_return(FooResponse.new("\"foobar\""))
    f = FooResource.new(:connection => conn)
    f._ref = "abcd" 
    f.do_it = false
    f.junction = "32"
    f.name = "jerry"
    f.sect = :fulburns
    f.put
    expect(f._ref).to eq("foobar")
  end

  it "should post with the right attributes" do
    conn = double
    uri = Infoblox.base_path + "foo:animal"
    allow(conn).to receive(:post).with(uri, {:name => "jerry", :junction => "32", :do_it => false, :sect => :fulburns}).and_return(FooResponse.new("\"abcdefg\""))
    f = FooResource.new(:connection => conn)
    f.do_it = false
    f.junction = "32"
    f.name = "jerry"
    f.sect = :fulburns
    f.post
    expect(f._ref).to eq('abcdefg')
  end

  it 'should set all attributes including readonly attrs' do
    f = FooResource.new(:readonly_thing => 45, :do_it => false, :sect => :larry)
    expect(f.readonly_thing).to eq(45)
    expect(f.do_it).to be(false)
    expect(f.sect).to eq(:larry)
  end
  
  it 'should map wapi objects to classes' do
    @expected = {}
    ObjectSpace.each_object(Class) do |p|
      if p < Infoblox::Resource
        @expected[p.wapi_object] = p
      end
    end
    expect(Infoblox::Resource.resource_map).to eq(@expected)
  end
end

