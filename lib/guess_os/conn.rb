
require 'net/ssh'

module GuessOS
  class Conn
    attr_reader :host
    attr_reader :ok
    attr_reader :status
    attr_reader :last_output

    def initialize(host)
      @host = host
      @last_output = ''
      @status = :unkown
      @ok = nil
    end

    def exec(command)
      remote_exec(command)
    end

    def local_exec(command)
    end

    def remote_exec(command)
      @ok = false
      output = 'Error'
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
          @status = :ok
          @ok = true
        end
      rescue Errno::EHOSTUNREACH
        @status = "[ERROR] Host #{@host.ip} unreachable!"
      rescue Net::SSH::AuthenticationFailed
        @status = '[ERROR] SSH::AuthenticationFailed!'
      rescue Net::SSH::HostKeyMismatch
        @status = 'SSH::HostKeyMismatch!'
        puts("* The destination server's fingerprint is not matching " \
            'what is in your local known_hosts file.')
        puts('* Remove the existing entry in your local known_hosts file')
        puts("* Try this => ssh-keygen -f '/home/USERNAME/.ssh/known_hosts' " \
            "-R #{@host.ip}")
      rescue StandardError => e
        @status = "[#{e.class}] SSH on <#{@host.username}@#{@host.ip}:#{@host.port}>" \
            " exec: #{command}"
      end
      @last_output = output
    end
  end
end
