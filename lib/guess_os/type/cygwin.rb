class Cygwin
  def self.guess(host)
    conn = GuessOS::Conn.new(host)
    command = "pwd"
    conn.exec(command)

    identified = conn.ok && conn.last_output.include?("/cygdrive")
    return GuessOS::OS.unkown unless identified

    output = conn.last_output
    type = :cygwin
    name = "cygwin"
    desc = output.delete("\n")
    GuessOS::OS.new(type, name, desc)
  end
end
