#!/usr/bin/env ruby

# require_relative '../lib/guess_os'
require "guess_os"

host = GuessOS::Host.new(ip: "localhost")

puts host.os.type
puts host.os.name
