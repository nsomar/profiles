# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'profiles/version'

Gem::Specification.new do |spec|
  spec.name          = "profiles"
  spec.version       = Profiles::VERSION
  spec.authors       = ["Omar Abdelhafith"]
  spec.email         = ["omar.abdelhafith@mttnow.com"]
  spec.summary       = %q{short summary}
  spec.description   = %q{long suppary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-reporters"

  # spec.add_dependency "cfpropertylist"
  spec.add_dependency "thor"
  spec.add_dependency "plist"
  spec.add_dependency "CFPropertyList", '~> 2.2'
  spec.add_dependency "nokogiri"
end
