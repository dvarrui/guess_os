
require_relative 'conn'
require_relative 'os'

module GuessOS
  module Type
    def self.guess(host)
      os = guess_gnulinux(host)
      return os unless os.type == :unkown

      os = guess_minix(host)
      return os unless os.type == :unkown

      os
    end

    def self.guess_gnulinux(host)
      list = %w(debian ubuntu opensuse manjaro)
      command = 'lsb_release -d'
      conn = GuessOS::Conn.new(host)

      conn.exec(command)
      return OS.new(:unkown, :unkown, conn.status) unless conn.ok

      output = conn.last_output
      items = output.split
      type =  'gnu/linux'
      name =  items[1]&.downcase
      desc =  output

      unless list.include? name
        return OS.new(:unkown, :unkown, 'Unkown OS')
      end

      OS.new(type, name, desc)
    end

    def self.guess_minix(host)
      command = 'cat /etc/rc.d/minixrc |grep MINIX| head -n 1'
      conn = GuessOS::Conn.new(host)

      conn.exec(command)
      return OS.new(:unkown, :unkown, conn.status) unless conn.ok

      output = conn.last_output
      items = output.split
      type =  'minix'
      name =  'minix'
      desc =  output.gsub("\n", '')
      OS.new(type, name, desc)
    end

    def self.guess_windows(host)
      command = 'echo %windir%'
      conn = GuessOS::Conn.new(host)

      conn.exec(command)
      return OS.new(:unkown, :unkown, conn.status) unless conn.ok

      output = conn.last_output
      items = output.split
      type =  'windows'
      name =  'windows'
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
