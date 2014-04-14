require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe "ElasticSearch Server" do

  it "is listening on port 9200" do
    expect(port(9200)).to be_listening
  end

  it "has a running service of elasticsearch" do
    expect(service("elasticsearch")).to be_running
  end

end