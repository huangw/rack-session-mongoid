# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/session/mongoid/version'

Gem::Specification.new do |spec|
  spec.name          = 'rack-session-mongoid'
  spec.version       = Rack::Session::Mongoid::VERSION
  spec.authors       = ['Huang Wei']
  spec.email         = ['huangw@pe-po.com']

  spec.summary       = 'Rack session store supports mongoid 5.0.'
  spec.description   = 'Rack session store supports mongoid 5.0.'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 4.2'
  spec.add_dependency 'mongoid', '~> 5.0'
  spec.add_dependency 'rack', '~> 1.6'

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.35'
  spec.add_development_dependency 'awesome_print', '~> 1.6'
end
