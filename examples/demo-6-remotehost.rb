#!/usr/bin/env ruby

require 'guess_os'
# require_relative '../lib/guess_os'

host = GuessOS::Host.new(
  ip: '192.168.1.42',
  port: 2241,
  username: 'vagrant',
  password: 'vagrant'
)

puts host.os.name

