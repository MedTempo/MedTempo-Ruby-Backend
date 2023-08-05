=begin 
require "redis"

cache = Redis.new(host: ENV["REDIS_HOST"], port: ENV["REDIS_PORT"], username:  ENV["REDIS_USR"], password: ENV["REDIS_PASS"]) 

cache.set "hello", "REDDDDDDDDDDDDDDDDDDDISSSSSSSSS"
puts cache.get "hello"


cache = Redis.new(host: "redis-11349.c308.sa-east-1-1.ec2.cloud.redislabs.com", port: 11349, username: "default", password: "m1wtOcgR6yZ1TWYVMTA80SI5PdGF5ARJ",)


=end