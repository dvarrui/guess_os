#!/usr/bin/env ruby

require_relative '../lib/guess_os/host'
require_relative '../lib/guess_os/conn'

puts "[GuessOS] demo 2"

host = GuessOS::Host.new(
  ip: 'localhost',
  port: 2241,
  username: 'vagrant',
  password: 'vagrant'
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
puts "    name = #{host.os[:name]}"
puts "    desc = #{host.os[:desc]}"
