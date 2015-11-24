require 'spec_helper'

describe Rack::Session::Mongoid do
  it 'has a version number' do
    expect(Rack::Session::Mongoid::VERSION).to_not be nil
  end
end
