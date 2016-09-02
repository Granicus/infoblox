require 'spec_helper'
describe Infoblox::Connection do

  ["localhost", "127.0.0.1", "http://localhost:3000", "https://localhost", "http://localhost:3000/"].each do |host|
    it "should build URL #{host} without failure" do
      conn_params = {
        :username => "billy",
        :password => "boi",
        :host =>     host
      }
      uri = "/wapi/v1.0/record:host"

      ic = Infoblox::Connection.new(conn_params)
      ic.adapter       = :test
      ic.adapter_block = stub_get(uri)

      # execute the request. There should be no "URI::BadURIError: both URI are relative" error
      ic.get(uri)
    end
  end

  it "should raise on invalid response" do
    host        = 'localhost'
    conn_params = {
      :username => "billy",
      :password => "boi",
      :host =>     host
    }
    uri         = "/wapi/v1.0/record:host"

    ic               = Infoblox::Connection.new(conn_params)
    ic.adapter       = :test
    ic.adapter_block = stub_get(uri, 404)

    # execute the request. There should be no "URI::BadURIError: both URI are relative" error

    expect { ic.get(uri) }.to raise_error(Infoblox::Error)
  end

  def stub_get(uri, status=200)
    Proc.new do |stub|
      stub.get(uri) { [ status, {}, 'Yay!'] }
    end
  end
end
