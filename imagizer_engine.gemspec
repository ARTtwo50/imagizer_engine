# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imagizer_engine/version'

Gem::Specification.new do |spec|
  spec.name          = "imagizer_engine"
  spec.version       = ImagizerEngine::VERSION
  spec.authors       = ["sfkaos"]
  spec.email         = ["win@vangoart.co"]
  spec.summary       = %q{Ruby client for using the Imagizer Media Engine from nvnentify.}
  spec.description   = %q{Super simple ruby client to use the Imagizer Media Engine created by nventify. Imagizer is a real-time image processing engine on top of AMAZON aws. 
    Install the engine using the AWS Marketplace.     =You can find it at www.imagizercdn.com.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
