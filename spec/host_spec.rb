require 'spec_helper'
HostResponse = Struct.new(:body)
describe Infoblox::Host, "#add_ipv4addr" do
  it "adds an address correctly" do
    host = Infoblox::Host.new
    host.add_ipv4addr("10.10.10.10")
    host.add_ipv4addr("10.10.10.12")
    expect(host.ipv4addrs[0]).to be_a(Infoblox::HostIpv4addr)
    expect(host.ipv4addrs[0].ipv4addr).to eq("10.10.10.10")
  end

  it "initializes correctly" do
    data = {
      :name      => 'silly-little-host',
      :ipv4addrs => [{:ipv4addr => '10.10.10.10'}]
    }
    host = Infoblox::Host.new(data)
    expect(host.ipv4addrs[0]).to be_a(Infoblox::HostIpv4addr)
    expect(host.name).to eq('silly-little-host')
  end

  it "posts correctly" do
    conn = double
    uri = Infoblox.base_path + Infoblox::Host.wapi_object

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
    expect(h._ref).to eq("hey")
  end
end

