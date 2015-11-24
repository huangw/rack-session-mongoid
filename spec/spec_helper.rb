require 'bundler/setup'
require 'active_support/all'
require 'mongoid'

Mongoid.load!('config/mongoid.yml', ENV['RACK_ENV'] || :development)

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rack/session/mongoid'

require 'rspec'
