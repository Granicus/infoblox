require 'spec_helper'
describe Infoblox::Host, "#add_ipv4addr" do
  it "adds an address correctly" do
    host = Infoblox::Host.new
    host.add_ipv4addr("10.10.10.10")
    host.add_ipv4addr("10.10.10.12")
    host.ipv4addrs.should eq([{:ipv4addr => "10.10.10.10"}, {:ipv4addr => "10.10.10.12"}])
  end
end

