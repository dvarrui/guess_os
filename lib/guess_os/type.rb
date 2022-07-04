
module GuessOS
  class Type
    attr_reader :host
    attr_reader :name, :desc

    def initialize(host)
      @host = host
      @name = :unkown
      @desc = :unkown
    end

    def show_info
      puts "\n"
      puts "==> Show Type info (#{@host.ip}:#{@host.port})"
      puts "    name = #{@name}"
      puts "    desc = #{@desc}"
    end

    def to_s
      { name: @name, desc: @desc}
    end

    def guess
    end
  end
end