
require 'net/ssh'

module GuessOS
  class Conn
    attr_reader :host
    attr_reader :last_output

    def initialize(host)
      @host = host
      @last_output = ''
    end

    def exec(command)
      output = ''
      begin
        session = Net::SSH.start(@host.ip,
                                 @host.username,
                                 port: @host.port,
                                 password: @host.password,
                                 keepalive: true,
                                 timeout: 30,
                                 non_interactive: true)
        if session.class == Net::SSH::Connection::Session
          output = session.exec!(command)
        end
      rescue Errno::EHOSTUNREACH
        puts ("[ERROR] Host #{@host.ip} unreachable!")
      rescue Net::SSH::AuthenticationFailed
        puts('[ERROR] SSH::AuthenticationFailed!')
      rescue Net::SSH::HostKeyMismatch
        puts('SSH::HostKeyMismatch!')
        puts("* The destination server's fingerprint is not matching " \
            'what is in your local known_hosts file.')
        puts('* Remove the existing entry in your local known_hosts file')
        puts("* Try this => ssh-keygen -f '/home/USERNAME/.ssh/known_hosts' " \
            "-R #{@host.ip}")
      rescue StandardError => e
        puts("[#{e.class}] SSH on <#{@host.username}@#{@host.ip}:#{@host.port}>" \
            " exec: #{command}")
        exit 1
      end
      @last_output = output
    end
  end
end
