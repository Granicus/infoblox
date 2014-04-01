require 'spec_helper'
HostResponse = Struct.new(:body)
describe Infoblox::Host, "#add_ipv4addr" do
  it "adds an address correctly" do
    host = Infoblox::Host.new
    host.add_ipv4addr("10.10.10.10")
    host.add_ipv4addr("10.10.10.12")
    host.ipv4addrs[0].should be_a(Infoblox::HostIpv4addr)
    host.ipv4addrs[0].ipv4addr.should eq("10.10.10.10")
  end

  it "posts correctly" do
    conn = double
    uri = Infoblox::BASE_PATH + Infoblox::Host.wapi_object

    allow(conn).to receive(:post).with(uri, {
      :ipv4addrs => [{:ipv4addr => "10.10.10.10"}, 
                     {:ipv4addr => "192.168.1.1", 
                      :mac => "109coic0932j3n0293urf"}],
                      :name => "test-server.test.ing"
      }).and_return(HostResponse.new("\"hey\""))

    h = Infoblox::Host.new(:connection => conn)
    h.add_ipv4addr("10.10.10.10")
    h.ipv4addrs=([{:ipv4addr => "192.168.1.1", :mac => "109coic0932j3n0293urf"}])
    h.name = "test-server.test.ing"
    h.post
    h._ref.should eq("hey")
  end
end

