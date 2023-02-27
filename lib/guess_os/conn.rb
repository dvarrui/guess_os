require "net/ssh"

module GuessOS
  class Conn
    attr_reader :host
    attr_reader :ok
    attr_reader :status
    attr_reader :last_output

    def initialize(host)
      @host = host
      @last_output = ""
      @status = nil
      @ok = nil
    end

    def exec(command)
      @ok = :unkown
      @status = :unkown

      return local_exec(command) if host.local?
      remote_exec(command)
    end

    def local_exec(command)
      begin
        output = `#{command}`
      rescue
        @ok = false
        @status = "Error: Command not found!"
      end
      if $?.nil?
        @ok = false
        @status = "Error: Command not found!"
      elsif $?.exitstatus.zero?
        @ok = true
        @status = "Ok"
      else
        @ok = false
        @status = "Exit status: #{$?.exitstatus}"
      end

      @last_output = if output.nil?
        ""
      else
        output.encode(Encoding::UTF_8, invalid: :replace)
      end
    end

    def remote_exec(command)
      output = "Error"
      begin
        session = Net::SSH.start(@host.ip,
          @host.username,
          port: @host.port,
          password: @host.password,
          keepalive: true,
          timeout: 30,
          non_interactive: true)
        if session.instance_of?(Net::SSH::Connection::Session)
          output = session.exec!(command)
          @status = :ok
          @ok = true
        end
      rescue Errno::EHOSTUNREACH
        @status = "[ERROR] Host #{@host.ip} unreachable!"
      rescue Net::SSH::AuthenticationFailed
        @status = "[ERROR] SSH::AuthenticationFailed!"
      rescue Net::SSH::HostKeyMismatch
        @status = "SSH::HostKeyMismatch!"
        puts("* The destination server's fingerprint is not matching " \
            "what is in your local known_hosts file.")
        puts("* Remove the existing entry in your local known_hosts file")
        puts("* Try this => ssh-keygen -f '/home/USERNAME/.ssh/known_hosts' " \
            "-R #{@host.ip}")
      rescue SocketError
        @status = "[ERROR] SocketError with IP/port [#{@host.ip}:#{@host.port}]"
      rescue Errno::ECONNREFUSED
        @status = "[ERROR] ConnRefused: SSH on [#{@host.username}@#{@host.ip}:#{@host.port}]"
      rescue => e
        @status = "[#{e.class}] SSH on <#{@host.username}@#{@host.ip}:#{@host.port}>" \
            " exec: #{command}"
      end
      @last_output = if output.nil?
        ""
      else
        output.encode(Encoding::UTF_8, invalid: :replace)
      end
    end
  end
end
