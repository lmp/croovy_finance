# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'croovy/finance/version'

Gem::Specification.new do |spec|
  spec.name          = "croovy_finance"
  spec.version       = Croovy::Finance::VERSION
  spec.authors       = ["Eric Wollesen"]
  spec.email         = ["eric@leadtune.com"]
  spec.description   = %q{Financial calculations used by Croovy}
  spec.summary       = %q{APR}
  spec.homepage      = "http://croovy.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
