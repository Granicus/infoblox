require 'spec_helper'
describe Infoblox::HostIpv4addr do

  it "should have correct post attributes" do
    expected = [:host]
    expect(Infoblox::HostIpv4addr.remote_post_attrs).to eq(expected)

    expected = [:network, :ipv4addr, :configure_for_dhcp, :mac].sort
    expect(Infoblox::HostIpv4addr.remote_attrs.sort).to eq(expected)
  end
end  
  
