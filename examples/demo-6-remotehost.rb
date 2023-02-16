#!/usr/bin/env ruby

# require_relative '../lib/guess_os'
require "guess_os"

host = GuessOS::Host.new(
  ip: "192.168.1.42",
  port: 2241,
  username: "vagrant",
  password: "vagrant"
)

puts host.os.type
puts host.os.name
