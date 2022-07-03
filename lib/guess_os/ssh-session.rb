#!/usr/bin/env ruby

require 'net/ssh'

module RemoteOS
  class SSHSession
    attr_accessor :ip, :port, :username, :password
    attr_reader :last_output

    def initialize(args = {})
      @ip = args[:ip] || 'localhost'
      @port = args[:port] || '22'
      @username = args[:username] || 'root'
      @password =  args[:password] || 'vagrant'
      @last_output = ''
    end

    def show_info
      puts "\n[ RemoteOS::SSHSession ]\n"
      puts "  ip       => #{@ip}"
      puts "  port     => #{@port}"
      puts "  username => #{@username}"
      puts "  password => #{@password}"
    end

    def exec(command)
      output = ''
      begin
        session = Net::SSH.start(@ip,
                                 @username,
                                 port: @port,
                                 password: @password,
                                 keepalive: true,
                                 timeout: 30,
                                 non_interactive: true)
        if session.class == Net::SSH::Connection::Session
          output = session.exec!(@command)
        end
      rescue Errno::EHOSTUNREACH
        puts ("[ERROR] Host #{@ip} unreachable!")
      rescue Net::SSH::AuthenticationFailed
        puts('[ERROR] SSH::AuthenticationFailed!')
      rescue Net::SSH::HostKeyMismatch
        puts('SSH::HostKeyMismatch!')
        puts("* The destination server's fingerprint is not matching " \
            'what is in your local known_hosts file.')
        puts('* Remove the existing entry in your local known_hosts file')
        puts("* Try this => ssh-keygen -f '/home/USERNAME/.ssh/known_hosts' " \
            "-R #{@ip}")
      rescue StandardError => e
        puts("[#{e.class}] SSH on <#{@username}@#{@ip}:#{@port}>" \
            " exec: #{@command}")
        exit 1
      end
      #@result.exitstatus = text.exitstatus
      #[text, text.exitstatus]
      @last_output = output
    end
  end
end
