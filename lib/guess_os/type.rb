
require_relative 'conn'
require_relative 'os'

module GuessOS
  module Type
    def self.guess(host)
      command = 'lsb_release -d'
      conn = GuessOS::Conn.new(host)
      output = conn.exec(command)
      items = output.split

      type =  'gnu/linux'
      name =  items[1].downcase
      desc =  output

      OS.new(type, name, desc)
    end

    def revise_guess(host)
      commands = {
        win10: 'pwd',
        winserver: 'echo %windir%',
        minix: 'cat /etc/motd |grep MINIX'
      }

      position = {
        win10: 0,
        winserver: 0,
        minix: 7
      }
    end
  end
end
