require 'spec_helper'
describe Infoblox::HostIpv4addr do

  it "should have correct post attributes" do
    expected = [:host]
    expect(Infoblox::HostIpv4addr.remote_post_attrs).to eq(expected)

    expected = [:bootfile, :configure_for_dhcp, :ipv4addr, :mac, :network, :nextserver, :use_bootfile, :use_nextserver].sort
    expect(Infoblox::HostIpv4addr.remote_attrs.sort).to eq(expected)
  end
end  
  
