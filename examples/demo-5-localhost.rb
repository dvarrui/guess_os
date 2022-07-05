#!/usr/bin/env ruby
require 'guess_os'
# require_relative '../lib/guess_os'

host = GuessOS::Host.new(ip: 'localhost')
puts host.os.name
