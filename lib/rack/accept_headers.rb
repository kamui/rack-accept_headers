require 'rack'
require 'rack/accept_headers/header'
require 'rack/accept_headers/charset'
require 'rack/accept_headers/context'
require 'rack/accept_headers/encoding'
require 'rack/accept_headers/language'
require 'rack/accept_headers/media_type'
require 'rack/accept_headers/request'
require 'rack/accept_headers/response'

module Rack::AcceptHeaders
  # Enables Rack::AcceptHeaders to be used as a Rack middleware.
  def self.new(app, &block)
    Context.new(app, &block)
  end
end
