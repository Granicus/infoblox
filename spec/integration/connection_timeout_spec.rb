require 'spec_helper'
require 'socket'

describe 'Infoblox::Connection' do
  it "should timeout in defined time" do
    begin
      server = TCPServer.new('localhost', 8813)
      host = 'localhost:8813'
      conn_params = {
        :host => host,
        :timeout => 4
      }
      uri = "/wapi/v1.0"

      ic = Infoblox::Connection.new(conn_params)
      start = Time.now
      if RUBY_VERSION < "2.0"
        # old pinned version of faraday gem throws a different exception
        expect { ic.get(uri) }.to raise_error(Faraday::TimeoutError)
      else
        expect { ic.get(uri) }.to raise_error(Faraday::ConnectionFailed)
      end
      finish = Time.now
      # this should take approx. 4 seconds but let's be safe
      expect(finish - start).to be_between(3, 55)
    ensure
      server.close
    end
  end
end
