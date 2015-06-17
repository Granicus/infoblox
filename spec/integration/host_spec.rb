if ENV['INTEGRATION']
  describe 'Infoblox::Host' do
    describe '.find' do
      it 'should work' do
        each_version do 
          # the empty result will be [], so nil is bad. 
          expect(Infoblox::Host.find(connection, :max_results => 1)).to_not be_nil
        end
      end
    end
  end
end
