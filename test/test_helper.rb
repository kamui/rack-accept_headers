ENV['RACK_ENV'] = 'test'

require 'rack'
require 'minitest/autorun'
require 'rack/accept'

class Minitest::Test
  attr_reader :context
  attr_reader :response

  def status
    @response && @response.status
  end

  def request(env={}, method='GET', uri='/')
    @context = Rack::Accept.new(fake_app)
    yield @context if block_given?
    mock_request = Rack::MockRequest.new(@context)
    @response = mock_request.request(method.to_s.upcase, uri, env)
    @response
  end

  def fake_app(status=200, headers={}, body=[])
    lambda {|env| Rack::Response.new(body, status, headers).finish }
  end
end
