
require_relative 'ssh-session'

class Demo
  attr_reader :name, :desc
  attr_accessor :command

  def initialize(args = {})
    ip = args[:ip] || 'localhost'
    port = args[:port] || '22'
    username = args[:username] || 'root'
    password =  args[:password] || 'vagrant'
    @session = RemoteOS::SSHSession.new(ip: ip, port: port, username: username, password: password)
    @desc = :unkown
    @name = :unkown
    @command = 'lsb_release -d'
  end

  def show_info
    @session.show_info

    puts "\n[ RemoteOSDemo ]\n"
    puts "  command  => #{@command}"
    puts "  desc     <= #{@desc}"
    puts "  name     <= #{@name}"
  end

  def guess_type(args)
    @command = args[:command]
    position = args[:position]
    text = @session.exec(@command)

    words = text.split
    if words.size == 1
      desc = words[0]
      words = [ 'win', desc ]
    else
      words[0] = nil
    end
    @name = :empty
    @desc = :empty
    unless words[position].nil?
      @name = words[position].downcase
      @desc = words.compact.join('_')
    end
  end
end

