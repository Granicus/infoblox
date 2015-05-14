require 'spec_helper'
SearchResponse = Struct.new(:body)

describe Infoblox::Search, ".find" do
  it "searches correctly" do
    conn = double

    # empty response
    return_json = SearchResponse.new("[]")
    uri = Infoblox.base_path + Infoblox::Search.wapi_object
    allow(conn).to receive(:get).with(uri, {"search_string~" => "foo"}).and_return(return_json)
    expect(Infoblox::Search.find(conn, "search_string~" => "foo")).to eq([])

    # response with host
    return_json = SearchResponse.new('[
      {
        "_ref": "record:host/ZG5zLmhvc3QkLl9kZWZhdWx0LmdkaS50b3BzLmRtei1tYWlsc2VuZGVycy5xYy1nb3ZpcG10YTItZXA:foo-bar-baz.inner.domain/Organization",
        "ipv4addrs": [
            {
                "_ref": "record:host_ipv4addr/ZG5zLmhvc3RfYWRkcmVzcyQuX2RlZmF1bHQuZ2RpLnRvcHMuZG16LW1haWxzZW5kZXJzLnFjLWdvdmlwbXRhMi1lcC4xNzIuMjQuNC4xODQu:10.10.10.10/foo-bar-baz.inner.domain/Organization",
                "configure_for_dhcp": false,
                "host": "foo-bar-baz.inner.domain",
                "ipv4addr": "10.10.10.10"
            }
        ],
        "name": "foo-bar-baz.inner.domain",
        "view": "Organization"
      }
    ]')
    allow(conn).to receive(:get).with(uri, {"search_string~" => "foo"}).and_return(return_json)
    result = Infoblox::Search.find(conn, "search_string~" => "foo")
    expect(result[0]).to be_a(Infoblox::Host)
    host = result[0]
    expect(host.name).to eq("foo-bar-baz.inner.domain")
  end
end

