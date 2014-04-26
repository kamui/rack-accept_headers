require 'rack'
require 'rack/accept/header'
require 'rack/accept/charset'
require 'rack/accept/context'
require 'rack/accept/encoding'
require 'rack/accept/language'
require 'rack/accept/media_type'
require 'rack/accept/request'
require 'rack/accept/response'

module Rack::Accept
  # Enables Rack::Accept to be used as a Rack middleware.
  def self.new(app, &block)
    Context.new(app, &block)
  end
end
