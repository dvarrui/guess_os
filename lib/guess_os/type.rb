require_relative "conn"
require_relative "os"

module GuessOS
  module Type
    def self.guess(host)
      os = guess_gnulinux(host)
      return os unless os.type == :unkown

      os = guess_macos(host)
      return os unless os.type == :unkown

      os = guess_windows(host)
      return os unless os.type == :unkown

      os = guess_cygwin(host)
      return os unless os.type == :unkown

      os = guess_minix(host)
      return os unless os.type == :unkown

      os
    end

    def self.guess_gnulinux(host)
      conn = GuessOS::Conn.new(host)
      command = "lsb_release -d"

      conn.exec(command)
      return OS.new(:unkown, :unkown, conn.status) unless conn.ok

      output = conn.last_output
      items = output.split
      type = :gnulinux
      name = items[1]&.downcase
      desc = output

      list = %w[debian ubuntu opensuse manjaro mint arch]
      unless list.include? name
        return OS.new(:unkown, :unkown, "Unkown OS")
      end

      OS.new(type, name, desc)
    end

    def self.guess_windows(host)
      conn = GuessOS::Conn.new(host)
      command = "ver"
      conn.exec(command)
      # ver => Microsoft Windows [Version 10.0.20348.469]
      # command = 'echo %windir%' => Windows

      identified = conn.ok && conn.last_output.include?("Windows")
      return OS.new(:unkown, :unkown, conn.status) unless identified

      output = conn.last_output
      output.delete!("\r")
      output.delete!("\n")
      items = output.split

      type = :windows
      name = "windows #{items[3].split(".").first}"
      desc = output
      OS.new(type, name, desc)
    end

    def self.guess_cygwin(host)
      conn = GuessOS::Conn.new(host)
      command = "pwd"
      conn.exec(command)

      identified = conn.ok && conn.last_output.include?("/cygdrive")
      return OS.new(:unkown, :unkown, conn.status) unless identified

      output = conn.last_output
      type = :cygwin
      name = "cygwin"
      desc = output.delete("\n")
      OS.new(type, name, desc)
    end

    def self.guess_macos(host)
      conn = GuessOS::Conn.new(host)
      command = "sw_vers | grep ProductName"
      conn.exec(command)
      # 1.9.2 kevin-macbookpro:~ $ system_profiler SPSoftwareDataType
      # System Version: Mac OS X 10.7.4 (11E53)
      #
      # 1.9.2 kevin-macbookpro:~ $ sw_vers
      # ProductName:    Mac OS X
      # ProductVersion: 10.7.4

      identified = conn.ok && conn.last_output.include?("Mac OS")
      return OS.new(:unkown, :unkown, conn.status) unless identified

      command = "sw_vers | grep ProductVersion"
      conn.exec(command)
      output = conn.last_output
      items = output.split

      type = :macos
      name = "Mac OS #{items[2].split(".").first}"
      desc = output
      OS.new(type, name, desc)
    end

    def self.guess_minix(host)
      conn = GuessOS::Conn.new(host)
      command = "cat /etc/rc.d/minixrc |grep MINIX| head -n 1"
      conn.exec(command)

      identified = conn.ok && conn.last_output.include?("MINIX")
      return OS.new(:unkown, :unkown, conn.status) unless identified

      output = conn.last_output
      type = :minix
      name = "minix"
      desc = output.delete("\n")
      OS.new(type, name, desc)
    end
  end
end
