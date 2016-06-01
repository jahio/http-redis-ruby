require 'json'
require 'redis'
require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'

#
# Application-specific libraries/classes
#
require_relative 'lib/key'

#
# DummyRedisApp
#
# Basic application that allows you to get and set keys and values
# using [redis](http://redis.io) as the back-end storage system.
#

class DummyRedisApp < Sinatra::Base
  register Sinatra::Namespace

  namespace '/api' do
    namespace '/v1' do

      get '/keys/:key' do
        if @key = Key.find(params['key'])
          json (@key.name.to_sym) => @key.value
        else
          json (params['key'].to_sym) => {status: 'not found'}
        end
      end

      post '/keys/:name' do
        @key = Key.new(params['name'], params['value'])
        if @key.save
          json (@key.name.to_sym) => @key.value
        else
          json params['name'] => {:status => 'save failed'}
        end
      end

    end # /namespace v1
  end # /namespace api
end
