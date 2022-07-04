
require_relative 'type'

module GuessOS
  class Host
    attr_reader :ip, :port, :username, :password
    attr_reader :os

    def initialize(args = {})
      @ip = args[:ip] || 'localhost'
      @port = args[:port] || '22'
      @username = args[:username] || 'root'
      @password =  args[:password] || 'vagrant'
      @os = GuessOS::Type.guess(self)
    end

    def local?
      return true if (ip == 'localhost') || (ip == '127.0.0.1')

      false
    end

    def remote?
      !local?
    end
  end
end
