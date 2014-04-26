lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/accept/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-accept"
  spec.version       = Rack::Accept::VERSION
  spec.authors       = ["Michael Jackson"]
  spec.email         = ["mjijackson@gmail.com"]
  spec.summary       = %q{HTTP Accept* for Ruby/Rack}
  spec.description   = %q{HTTP Accept, Accept-Charset, Accept-Encoding, and Accept-Language for Ruby/Rack}
  spec.homepage      = "https://github.com/mjijackson/rack-accept"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|test)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rack'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-minitest'
end
