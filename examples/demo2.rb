#!/usr/bin/env ruby

require_relative '../lib/guess_os/host'

puts "[GuessOS] demo 2"

host = GuessOS::Host.new(
  ip: 'localhost',
  port: 2241,
  username: 'vagrant',
  password: 'vagrant'
)
host.show_info

conn = host.create_conn

cmd = 'lsb_release -d'
puts "\n==> Execute command: #{cmd}"
puts "    #{conn.exec(cmd)}"

host.type.show_info
