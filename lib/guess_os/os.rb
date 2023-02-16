module GuessOS
  class OS
    attr_reader :type, :name, :desc

    def initialize(type, name, desc)
      @type = type
      @name = name.strip
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
