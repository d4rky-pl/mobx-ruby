# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mobx/version'

Gem::Specification.new do |s|
  s.name        = 'mobx-ruby'
  s.version     = Mobx::VERSION
  s.summary     = "Mobx implementation in Ruby"
  s.description = "An implementation of Mobx state management library"
  s.authors     = ["Michał Matyas"]
  s.email       = 'michal@higher.lv'

  s.files         = Dir.glob("lib/**/*") + %w(README.md LICENSE)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_development_dependency "rspec", "~> 3.5"
  s.add_development_dependency "rake", "~> 10.1"
  s.add_development_dependency "simplecov", "~> 0.9"
  s.add_development_dependency "coveralls", "~> 0.8"

  s.homepage    = 'https://github.com/d4rky-pl/mobx-ruby'
  s.license       = 'MIT'
end
