if ENV['INTEGRATION']
  require 'spec_helper'

  describe 'Infoblox::HostIpv4addr' do
    describe '.find' do
      it 'should work' do
        each_version do 
          # the empty result will be [], so nil is bad. 
          expect(Infoblox::HostIpv4addr.find(connection, :_max_results => 1)).to_not be_nil
        end
      end
    end
  end
end
