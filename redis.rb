require "redis"
require "redis/connection/hiredis"
require "nest"

class User < Struct.new(:id)
  def todos
    # Redis.current.smembers("User:#{id}:todos").map { |id| Todo[id] }
    ids  = redis.smembers("User:#{id}:todos")
    atts = redis.pipelined do
      ids.each { |id| redis.hgetall("Todo:#{id}") }
    end

    ids.map.with_index do |id, idx|
      Todo.new(Hash[*atts[idx]]).tap { |todo| todo.id = id }
    end
  end

  def redis
    Redis.current
  end
end

class Todo
  def self.[](id)
    new(key[id].hgetall).tap { |todo| todo.id = id }
  end

  attr_accessor :id
  attr_accessor :description
  attr_accessor :done

  def initialize(atts = {})
    atts.each do |key, val|
      send(:"#{key}=", val)
    end
  end

  def self.key
    @key ||= Nest.new(:Todo, Redis.current)
  end
end

module Startup
  def self.now!
    Redis.connect(path: "/tmp/redis.sock")
    Redis.current.flushdb

    descriptions = [
      'Foo Bar Baz',
      'Buy Milk',
      'Make some Coffee',
      'Read SICP',
      'Go to the gym',
      'Run in the marathon'
    ]

    descriptions.each_with_index do |d, i|
      id = i + 1

      Redis.current.sadd("User:1:todos", id)
      Redis.current.hmset("Todo:#{id}", :description, d)
    end
  end
end
