require_relative "type/all"

module GuessOS
  class Type
    TYPES = [ Windows, GNULinux, MacOS, Cygwin, Minix ]

    def self.guess(host)
      TYPES.each do |klass|
        os = klass.send :guess, host
        return os unless os.type == :unkown
      end
      os
    end
  end
end
