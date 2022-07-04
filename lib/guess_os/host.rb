
require_relative 'type'
require_relative 'conn'

module GuessOS
  class Host
    attr_reader :ip, :port, :username, :password
    attr_reader :type
    
    def initialize(args = {})
      @ip = args[:ip] || 'localhost'
      @port = args[:port] || '22'
      @username = args[:username] || 'root'
      @password =  args[:password] || 'vagrant'
      @type = GuessOS::Type.new(self)
    end

    def os
      @type.to_s
    end

    def show_info
      puts "\n"
      puts "==> Show host info"
      puts "    ip       = #{@ip}"
      puts "    port     = #{@port}"
      puts "    username = #{@username}"
      puts "    password = #{@password}"
    end

    def create_conn
      GuessOS::Conn.new(self)
    end
  end
end
