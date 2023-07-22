require "redis"

module RedisCache
    self.cache = Redis.new(host: ENV["REDIS_HOST"], port: ENV["REDIS_PORT"], username:  ENV["REDIS_USR"], password: ENV["REDIS_PASS"]) 

    cache.set "hello", "world"
end