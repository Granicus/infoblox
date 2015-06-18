if ENV['INTEGRATION']
  describe 'Infoblox::Host' do
    describe '.find' do
      it 'should find' do
        each_version do 
          # the empty result will be [], so nil is bad. 
          expect(Infoblox::Host.find(connection, :_max_results => 1)).to_not be_nil
        end
      end
      it 'should create, update, and destroy' do
        failure = false
        each_version do
          @host = Infoblox::Host.new(:connection => connection)
          begin
            @host.add_ipv4addr('10.30.30.30')
            @host.name = "poc-infobloxgem-test1.ep.gdi"
            @host.post

            @host = Infoblox::Host.find(connection, {"ipv4addr" => "10.30.30.30"}).first
            @host.name = "poc-infobloxgem-test2.ep.gdi"
            @host.put
          rescue Exception => e
            puts e
            failure = true
          ensure
            @host.delete
          end      
        end
        fail if failure
      end
    end
  end
end
