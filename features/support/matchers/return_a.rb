require 'rspec/matchers'
require 'net/https'

RSpec::Matchers.define :return_a do |expected|
  match do |actual|
    uri = URI.parse(actual)

    if uri.port == 80 || uri.host == "localhost"
      http = Net::HTTP.new(uri.host, uri.port)
    else
      http = Net::HTTP::Proxy('http-proxy.nwie.net', '8080').new(uri.host, uri.port)
    end
    if uri.scheme == 'https'
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    @http_response = http.get(uri.path)
    @http_response.should be_a expected
  end

  failure_message_for_should do |actual|
    "asking the server for #{actual} should return a #{expected}, got #{@http_response}"
  end

end