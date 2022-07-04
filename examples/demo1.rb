#!/usr/bin/env ruby

require_relative '../lib/guess_os/host'

puts "[GuessOS] demo 3"

print 'ip? '; ip = gets.chomp
print 'port? '; port = gets.to_i
print 'username? '; username = gets.chomp
print 'password? '; password = gets.chomp

host = GuessOS::Host.new(
  ip: ip,
  port: port,
  username: username,
  password: password
)

puts host.os.to_s
