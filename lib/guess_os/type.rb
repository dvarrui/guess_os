
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
      puts '==> Show Type info'
      puts "    desc = #{@desc}"
      puts "    name = #{@name}"
    end
  end
end
