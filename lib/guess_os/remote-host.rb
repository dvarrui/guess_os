#!/usr/bin/env ruby

require_relative 'guess-os'

module RemoteOS
  class RemoteHost
    attr_reader :os

    def initialize(args)
      @ip = args[:ip] || 'localhost'
      @port = args[:port] || '22'
      @username = args[:username] || 'root'
      @password =  args[:password] || 'vagrant'
      @os = :unkown
      @osname = :unkown
      @command = 'lsb_release -d'
    end

    def show_info
      puts "\n[ RemoteHost ]\n"
      puts "  ip       => #{@ip}"
      puts "  port     => #{@port}"
      puts "  username => #{@username}"
      puts "  password => #{@password}"
      puts "\n[ OS ]\n"
      puts "  desc     <= #{@desc}"
      puts "  name     <= #{@name}"
    end
end
