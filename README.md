# Rack::Session::Mongoid

Rack::Session::Mongoid store, only support the newest mongoid 5.0
(there is Rack::Session::Moped` that suports older version of mongoid).

## Installation

    gem install rack-session-mongoid

## Usage

Load `Mongoid` configuration, and then:

    use Rack::Session::Mongoid, collection: 'rack_session'
                                expires: 600 # in secounds
