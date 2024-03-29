module GuessOS
  class OS
    def self.unkown
      OS.new(:unkown, :unkown, "Unkown")
    end

    attr_reader :type, :name, :desc

    def initialize(type, name, desc)
      @type = type
      @name = name.to_s.strip
      @desc = clean(desc)
    end

    def to_s
      {type: @type, name: @name, desc: @desc}
    end

    private

    def clean(text)
      output = text.clone
      output.tr!("\t", " ")
      output.tr!("\n", " ")
      output.strip
    end
  end
end
