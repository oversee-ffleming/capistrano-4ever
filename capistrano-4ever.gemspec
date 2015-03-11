# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/forever/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-4ever"
  spec.version       = Capistrano::Forever::VERSION
  spec.authors       = ["Forrest Fleming"]
  spec.email         = ["ffleming@oversee.net"]
  spec.summary       = 'Capistrano3 tasks for deploying NodeJS servers via forever'
  spec.description   = 'Provides forever: namespace with several tasks for deploying NodeJS server via forever'
  spec.homepage      = "https://github.com/oversee-ffleming/capistrano-forever"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
