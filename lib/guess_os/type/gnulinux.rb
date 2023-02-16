class GNULinux
  def self.guess(host)
    conn = GuessOS::Conn.new(host)
    command = "lsb_release -d"

    conn.exec(command)
    return GuessOS::OS.new(:unkown, :unkown, conn.status) unless conn.ok

    output = conn.last_output
    items = output.split
    type = :gnulinux
    name = items[1]&.downcase
    desc = output

    list = %w[debian ubuntu opensuse manjaro mint arch]
    unless list.include? name
      return GuessOS::OS.new(:unkown, :unkown, "Unkown OS")
    end

    GuessOS::OS.new(type, name, desc)
  end
end
