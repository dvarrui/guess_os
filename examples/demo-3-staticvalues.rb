#!/usr/bin/env ruby

require_relative '../lib/guess_os/host'

puts "[GuessOS] #{$0}"
puts '-' * 50 + "\n"

host = GuessOS::Host.new(ip: 'localhost')
puts host.os.to_s
