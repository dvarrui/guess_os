
require_relative 'ai'

module GuessOS
  class Host
    attr_reader :ip, :port, :username, :password
    attr_reader :type

    def initialize(args = {})
      @ip = args[:ip] || 'localhost'
      @port = args[:port] || '22'
      @username = args[:username] || 'root'
      @password =  args[:password] || 'vagrant'
      @type = GuessOS::AI.guess_type(self)
    end

    def os
      @type.to_s
    end
  end
end
