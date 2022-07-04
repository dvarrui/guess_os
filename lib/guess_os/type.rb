
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
      command = 'lsb_release -d'
      conn = GuessOS::Conn.new(host)

      conn.exec(command)
      return OS.new(:unkown, :unkown, conn.status) unless conn.ok

      output = conn.last_output
      items = output.split
      type =  'gnu/linux'
      name =  items[1]&.downcase
      desc =  output
      OS.new(type, name, desc)
    end

    def self.guess_minix(host)
      command = 'cat /etc/motd |grep MINIX'
      conn = GuessOS::Conn.new(host)

      conn.exec(command)
      return OS.new(:unkown, :unkown, conn.status) unless conn.ok

      output = conn.last_output
      items = output.split
      type =  'minux'
      name =  items[7]&.downcase
      desc =  output
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
