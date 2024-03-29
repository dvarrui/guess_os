#!/usr/bin/env ruby

require_relative "../lib/guess_os/host"

puts "[GuessOS] #{$0}"

print "      ip? "
ip = gets.chomp
print "    port? "
port = gets.chomp
print "username? "
username = gets.chomp
print "password? "
password = gets.chomp

ip = "localhost" if ip.empty?
port = nil if port.empty?
username = nil if username.empty?
password = nil if password.empty?

host = GuessOS::Host.new(
  ip: ip,
  port: port,
  username: username,
  password: password
)

puts "=" * 50 + "\n"
puts host.os.to_s
