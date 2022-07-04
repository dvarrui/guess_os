
require_relative 'conn'

module GuessOS
  class Host
    attr_accessor :ip, :port, :username, :password

    def initialize(args = {})
      @ip = args[:ip] || 'localhost'
      @port = args[:port] || '22'
      @username = args[:username] || 'root'
      @password =  args[:password] || 'vagrant'
      @last_output = ''
    end

    def show_info
      puts "\n[GuessOS] Host info\n"
      puts "  ip       => #{@ip}"
      puts "  port     => #{@port}"
      puts "  username => #{@username}"
      puts "  password => #{@password}"
    end

    def create_conn
      GuessOS::Conn.new(self)
    end
  end
end
