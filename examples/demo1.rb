#!/usr/bin/env ruby

require_relative '../lib/guess_os/host'

puts "[GuessOS] demo 1"

host = GuessOS::Host.new(
  ip: 'localhost',
  port: 2241,
  username: 'vagrant',
  password: 'vagrant'
)

puts host.os