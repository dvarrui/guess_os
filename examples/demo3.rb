#!/usr/bin/env ruby

require_relative '../lib/guess_os/host'

puts "[GuessOS] #{$0}"

host = GuessOS::Host.new(
  ip: 'localhost',
  port: 2241,
  username: 'vagrant',
  password: 'vagrant'
)

puts host.os.to_s
