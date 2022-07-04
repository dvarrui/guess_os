
require_relative 'conn'
require_relative 'type'

module GuessOS
  module AI
    def self.guess_type(host)
      command = 'lsb_release -d'
      position = 1
      conn = GuessOS::Conn.new(host)
      output = conn.exec(command)
      items = output.split

      GuessOS::Type.new(name: items[position], desc: output)
    end

    def guess(host)
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
