require 'spec_helper'

NetworkResponse = Struct.new(:body)

describe Infoblox::Network, "#next_available_ip" do
  it "gets next available ip correctly" do
    connection = double
    uri = Infoblox::BASE_PATH + Infoblox::Network.wapi_object

    return_json = NetworkResponse.new('{"ips": "[]"}')
    allow(connection).to receive(:post).with(uri + "/10.10.10.10/24" + "?_function=next_available_ip", {:num=>1, :exclude=>[]}).and_return(return_json)
    response = Infoblox::Network.new(:connection => connection, :network => "10.10.10.10/24")
    expect(response.next_available_ip).to eq '[]'


    return_json = NetworkResponse.new('
      {
        "ips": "[\"1.1.1.1\", \"1.1.1.2\"]"
      }')

    allow(connection).to receive(:post).with(uri + "/10.10.10.10/24" + "?_function=next_available_ip", {:num=>1, :exclude=>[]}).and_return(return_json)
    response = Infoblox::Network.new(:connection => connection, :network => "10.10.10.10/24")
    expect(response.next_available_ip).to eq '["1.1.1.1", "1.1.1.2"]'
  end
end