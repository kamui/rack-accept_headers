lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/accept_headers/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-accept_headers"
  spec.version       = Rack::AcceptHeaders::VERSION
  spec.authors       = ["Jack Chu", "Michael Jackson"]
  spec.email         = ["kamuigt@gmail.com", "mjijackson@gmail.com"]
  spec.summary       = %q{HTTP Accept* for Ruby/Rack}
  spec.description   = %q{HTTP Accept, Accept-Charset, Accept-Encoding, and Accept-Language for Ruby/Rack}
  spec.homepage      = "https://github.com/kamui/rack-accept_headers"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rack', '>= 1.5.2'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-minitest'
end
