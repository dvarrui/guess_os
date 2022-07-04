
module GuessOS
  class Type
    attr_reader :host
    attr_reader :name, :desc

    def initialize(host)
      @host = host
      @desc = :unkown
      @name = :unkown
    end

    def show_info
      puts "\n"
      puts "==> Show Type info (#{@host.ip}:#{@host.port})"
      puts "    desc = #{@desc}"
      puts "    name = #{@name}"
    end

    def guess
    end
  end
end
