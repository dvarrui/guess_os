class Minix
  def self.guess(host)
    conn = GuessOS::Conn.new(host)
    command = "cat /etc/rc.d/minixrc |grep MINIX| head -n 1"
    conn.exec(command)

    identified = conn.ok && conn.last_output.include?("MINIX")
    return GuessOS::OS.unkown unless identified

    output = conn.last_output
    type = :minix
    name = "minix"
    desc = output.delete("\n")
    GuessOS::OS.new(type, name, desc)
  end
end
