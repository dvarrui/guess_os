class Windows
  def self.guess(host)
    conn = GuessOS::Conn.new(host)
    command = "ver"
    conn.exec(command)
    # ver => Microsoft Windows [Version 10.0.20348.469]
    # command = 'echo %windir%' => Windows

    identified = conn.ok && conn.last_output.include?("Windows")
    return GuessOS::OS.new(:unkown, :unkown, conn.status) unless identified

    output = conn.last_output
    output.delete!("\r")
    output.delete!("\n")
    items = output.split

    type = :windows
    name = "windows #{items[3].split(".").first}"
    desc = output
    GuessOS::OS.new(type, name, desc)
  end
end
