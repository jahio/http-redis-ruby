require 'json'
require 'redis'
require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'

#
# TODO: Set up redis access + bootstrap all the things
#

#
# DummyRedisApp
#
# Basic application that allows you to get and set keys and values
# using [redis](http://redis.io) as the back-end storage system.
#

class DummyRedisApp < Sinatra::Base
  #
  # Set up things from sinatra-contrib like namespaces,
  # special param stuff, json, etc.
  #
  register Sinatra::Namespace

  namespace '/api' do
    namespace '/v1' do

      get '/keys/:key' do
        # TODO: Look up key in redis, return its value in JSON
        json :todo => 'NYI (not yet implemented)'
      end

      post '/keys' do
        # TODO: Create new object, save in redis
        json :obj => 'NYI (not yet implemented)'
      end

      put '/keys/:key' do
        # TODO: If key exists, make its value equal to post data
        # TODO: If key does not exist, respond 404
        json :obj => 'NYI (not yet implemented)'
      end

    end # /namespace v1
  end # /namespace api
end
