require_relative "type/all"

module GuessOS
  class Type
    def self.guess(host)
      os = Windows.guess(host)
      return os unless os.type == :unkown

      os = GNULinux.guess(host)
      return os unless os.type == :unkown

      os = MacOS.guess(host)
      return os unless os.type == :unkown

      os = Cygwin.guess(host)
      return os unless os.type == :unkown

      os = Minix.guess(host)
      return os unless os.type == :unkown

      os
    end
  end
end
