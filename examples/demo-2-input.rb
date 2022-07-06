#!/usr/bin/env ruby

require_relative '../lib/guess_os/host'

puts "[GuessOS] #{$0}"

print '      ip? '; ip = gets.chomp
print '    port? '; port = gets.chomp
print 'username? '; username = gets.chomp
print 'password? '; password = gets.chomp

ip = 'localhost' if ip.empty?
port = nil if port.empty?
username = nil if username.empty?
password = nil if password.empty?

host = GuessOS::Host.new(
  ip: ip,
  port: port,
  username: username,
  password: password
)

puts "\n"
puts "==> Show host info"
puts "    ip       = #{host.ip}"
puts "    port     = #{host.port}"
puts "    username = #{host.username}"
puts "    password = #{host.password}"

conn = GuessOS::Conn.new(host)

cmd = 'lsb_release -d'
puts "\n==> Execute command: #{cmd}"
puts "    #{conn.exec(cmd)}"

puts "\n"
puts "==> Show Type info (#{host.ip}:#{host.port})"
puts "    type = #{host.os.type}"
puts "    name = #{host.os.name}"
puts "    desc = #{host.os.desc}"
