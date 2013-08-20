require 'spec_helper'
describe Infoblox::Host, "#add_ipv4addr" do
  it "adds an address correctly" do
    host = Infoblox::Host.new
    host.add_ipv4addr("10.10.10.10")
    host.add_ipv4addr("10.10.10.12")
    host.ipv4addrs[0].should be_a(Infoblox::Ipv4addr)
    host.ipv4addrs[0].ipv4addr.should eq("10.10.10.10")
  end
end

