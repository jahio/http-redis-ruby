#!/usr/bin/env ruby
require 'rubygems'
require 'redis'
require 'json'

$redis = Redis.new(:url => (ENV['REDIS_URL'] || 'redis://localhost:6379/0'))

#
# A wicked simple class for building, saving and finding objects
# within redis.
#
class Key
  attr_accessor :name
  attr_accessor :value

  def initialize(name = nil, value = nil)
    @name  = name
    @value = value
  end

  #
  # REQUIREMENTS WHEN SAVING A KEY AND ITS VALUE
  #
  # + @name  MUST   be a valid name for a key in redis;
  # + @name  CANNOT be blank or nil
  # + @value MUST   be a string encoded in UTF-8
  # + @value MAY    be a blank string (used to invalidate a key)
  #
  def save
    if @name.nil? || @name.length < 1
      raise Key::NameBlankError, "A key's name property cannot be blank or nil."
      return false
    end
    $redis.set(@name, @value)
  end

  #
  # HOW TO FIND A GIVEN KEY
  #
  # Key.find(name) # => returns the string value of the key named 'name'
  #
  def self.find(name)
    if k = $redis.get(name)
      return Key.new(name, k)
    end
    return nil
  end

  #
  # An error to be raised when trying to save a key with a name that's
  # blank or nil; prevents trying to send junk queries to redis.
  #
  class NameBlankError < StandardError; end
end
