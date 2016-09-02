if ENV['INTEGRATION']
  require 'spec_helper'

  describe 'Infoblox::Ptr' do
    describe '.find' do
      it 'should work' do
        each_version do
          expect(Infoblox::Ptr.find(connection, "ipv4addr~" => "10.*", "_max_results" => 1)).to_not be_nil
        end
      end
    end
  end
end
