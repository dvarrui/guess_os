
require_relative 'conn'
require_relative 'os'

module GuessOS
  module Type
    def self.guess(host)
      os = guess_gnulinux(host)
      return os unless os.type == :unkown

      os = guess_minix(host)
      return os unless os.type == :unkown

      os = guess_cygwin(host)
      return os unless os.type == :unkown

      os
    end

    def self.guess_gnulinux(host)
      conn = GuessOS::Conn.new(host)
      command = 'lsb_release -d'

      conn.exec(command)
      return OS.new(:unkown, :unkown, conn.status) unless conn.ok

      output = conn.last_output
      items = output.split
      type =  'gnu/linux'
      name =  items[1]&.downcase
      desc =  output

      list = %w(debian ubuntu opensuse manjaro)
      unless list.include? name
        return OS.new(:unkown, :unkown, 'Unkown OS')
      end

      OS.new(type, name, desc)
    end

    def self.guess_minix(host)
      conn = GuessOS::Conn.new(host)
      command = 'cat /etc/rc.d/minixrc |grep MINIX| head -n 1'

      conn.exec(command)

      identified = conn.ok && conn.last_output.include?('MINIX')
      return OS.new(:unkown, :unkown, conn.status) unless identified

      output = conn.last_output
      items = output.split
      type =  'minix'
      name =  'minix'
      desc =  output.gsub("\n", '')
      OS.new(type, name, desc)
    end

    def self.guess_cygwin(host)
      conn = GuessOS::Conn.new(host)
      command = 'pwd'
      conn.exec(command)

      identified = conn.ok && conn.last_output.include?('/cygdrive')
      return OS.new(:unkown, :unkown, conn.status) unless identified

      output = conn.last_output
      type =  'cygwin'
      name =  'cygwin'
      desc =  output.gsub("\n", '')
      OS.new(type, name, desc)
    end

    def reviseguess(host)
      commands = {
        win10: 'pwd',
        winserver: 'echo %windir%',
      }

      position = {
        win10: 0,
        winserver: 0,
      }
    end
  end
end
