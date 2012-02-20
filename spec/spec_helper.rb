require 'webmock/rspec'
require 'vcr'
require 'ldoce'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |config|
  counter=0
  GC.disable

  config.after(:each) do
    if (counter+=1) % 20 == 0
      GC.enable; GC.start; GC.disable
    end
  end
  WebMock.disable_net_connect!
  config.mock_with :rspec
end
