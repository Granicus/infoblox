require 'spec_helper'

RangeResponse = Struct.new(:body)

describe Infoblox::Host, "#next_available_ip" do  
  it "returns empty array when no IP is available." do
    connection = double
    uri = Infoblox.base_path + Infoblox::Range.wapi_object
    return_json = RangeResponse.new('{"ips": "[]"}')
    allow(connection).to receive(:post).with(uri + "?_function=next_available_ip" , {:num=>1, :exclude=>[]}).and_return(return_json)
    response = Infoblox::Range.new(:connection => connection)
    expect(response.next_available_ip).to eq '[]'
  end

  it "gets next available ip from range" do
    connection = double
    uri = Infoblox.base_path + Infoblox::Range.wapi_object
    return_json = RangeResponse.new('
      {
        "ips": "[\"1.1.1.1\", \"1.1.1.2\"]"
      }')
    allow(connection).to receive(:post).with(uri + "?_function=next_available_ip" , {:num=>1, :exclude=>[]}).and_return(return_json)
    response = Infoblox::Range.new(:connection => connection)
    expect(response.next_available_ip).to eq '["1.1.1.1", "1.1.1.2"]'

  end
end
