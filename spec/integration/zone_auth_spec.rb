if ENV['INTEGRATION']
  describe 'Infoblox::ZoneAuth' do
    describe '.find' do
      it 'should find' do
        each_version do 
          next if Infoblox.wapi_version < '1.1'
          # the empty result will be [], so nil is bad. 
          expect(Infoblox::ZoneAuth.find(connection, :_max_results => 1)).to_not be_nil
        end
      end
      
      it 'should create, update, and destroy' do
        failure = false
        each_version do
          next if Infoblox.wapi_version < '1.1'
          @zone_auth = Infoblox::ZoneAuth.new(:connection => connection)
          begin
            @zone_auth.fqdn = "poc-infobloxgem-test1.ep.gdi"
            @zone_auth.post
            @zone_auth = Infoblox::ZoneAuth.find(connection, {"fqdn" => "poc-infobloxgem-test1.ep.gdi"}).first
            @zone_auth.comment = "Test zone auth. Delete me"
            @zone_auth.put
          rescue Exception => e
            puts e
            failure = true
          ensure
            @zone_auth.delete
          end      
        end
        fail if failure
      end
    end
  end
end
