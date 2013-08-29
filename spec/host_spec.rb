require 'spec_helper'
HostResponse = Struct.new(:body)
describe Infoblox::Host, "#add_ipv4addr" do
  it "adds an address correctly" do
    host = Infoblox::Host.new
    host.add_ipv4addr("10.10.10.10")
    host.add_ipv4addr("10.10.10.12")
    host.ipv4addrs[0].should be_a(Infoblox::Ipv4addr)
    host.ipv4addrs[0].ipv4addr.should eq("10.10.10.10")
  end

  it "posts correctly" do
    conn = double
    uri = Infoblox::BASE_PATH + Infoblox::Host.wapi_object

    allow(conn).to receive(:post).with(uri, {
      :ipv4addrs => [{:ipv4addr => "10.10.10.10"}],
      :name => "test-server.test.ing",
      :configure_for_dns => nil,
      :extensible_attributes => nil}).and_return(HostResponse.new("hey"))

    Infoblox::Host.connection = conn
    h = Infoblox::Host.new
    h.add_ipv4addr("10.10.10.10")
    h.name = "test-server.test.ing"
    h.post
  end
end

