# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'working_class/version'

Gem::Specification.new do |spec|
  spec.name          = "working_class"
  spec.version       = WorkingClass::VERSION
  spec.authors       = ["Tim Kächele"]
  spec.email         = ["TimKaechele@me.com"]
  spec.summary       = "WorkingClass is an easy to use todolist syntax"
  spec.description   = "Working Class is a todolist syntax that aims at making " +
                       "it dead simple to write tasks in an human readable way " +
                       "that is also parseable."
  spec.homepage      = "http://github.com/TimKaechele/WorkingClass"
  spec.license       = "GNU GPL v3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.5.1"
end
