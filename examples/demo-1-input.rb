#!/usr/bin/env ruby

require_relative '../lib/guess_os/host'

puts "[GuessOS] #{$0}"

print '      ip? '; ip = gets.chomp
print '    port? '; port = gets.to_i
print 'username? '; username = gets.chomp
print 'password? '; password = gets.chomp

host = GuessOS::Host.new(
  ip: ip,
  port: port,
  username: username,
  password: password
)

puts '=' * 50 + "\n"
puts host.os.to_s
