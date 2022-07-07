module GuessOS
  class OS
    attr_reader :type, :name, :desc

    def initialize(type, name, desc)
      @type = type
      @name = name
      @desc = desc
    end

    def to_s
      {type: @type, name: @name, desc: @desc}
    end
  end
end
