class MacOS
  def self.guess(host)
    conn = GuessOS::Conn.new(host)
    command = "sw_vers | grep ProductName"
    conn.exec(command)
    # 1.9.2 kevin-macbookpro:~ $ system_profiler SPSoftwareDataType
    # System Version: Mac OS X 10.7.4 (11E53)
    #
    # 1.9.2 kevin-macbookpro:~ $ sw_vers
    # ProductName:    Mac OS X
    # ProductVersion: 10.7.4

    identified = conn.ok && conn.last_output.include?("Mac OS")
    return GuesOS::OS.new(:unkown, :unkown, conn.status) unless identified

    command = "sw_vers | grep ProductVersion"
    conn.exec(command)
    output = conn.last_output
    items = output.split

    type = :macos
    name = "Mac OS #{items[2].split(".").first}"
    desc = output
    GuessSO::OS.new(type, name, desc)
  end
end
