require 'active_support/all'
require 'mongoid'
require 'rack/session/mongoid'

Mongoid.load!('config/mongoid.yml', ENV['RACK_ENV'] || :development)

class SimpleApp
  def self.call(env)
    env["rack.session"]["counter"] ||= 0
    env["rack.session"]["counter"] = env["rack.session"]["counter"] + 1
    # ap env['rack.session']['counter']

    [200, # 200 indicates success
     { 'Content-Type' => 'text/plain' },
     ["Hello from Rack! (counter: #{env['rack.session']['counter']})"]
    ]
  end
end

# use Rack::Session::Pool
use Rack::Session::Mongoid
run SimpleApp
