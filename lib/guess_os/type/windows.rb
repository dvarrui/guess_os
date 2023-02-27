class Windows
  def self.guess(host)
    conn = GuessOS::Conn.new(host)

    os = try_with_regedit(conn)
    return os unless os.type == :unkown

    os = try_with_ver(conn)
    return os unless os.type == :unkown

    try_with_folder(conn)
  end

  def self.try_with_regedit(conn)
    command = "reg query \"HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion\" /t REG_SZ"
    conn.exec(command)

    identified = conn.ok && conn.last_output.include?("Windows")
    return GuessOS::OS.unkown unless identified

    output = conn.last_output
    begin
      lines = output.split("\n")
      filter = lines.filter { _1.include? "ProductName" }
      filter[0].gsub!("ProductName", "")
      filter[0].gsub!("REG_SZ", "")

      desc = filter[0].strip
      items = desc.split
      name = "#{items[0]} #{items[1]}"

      GuessOS::OS.new(:windows, name, desc)
    rescue
      GuessOS::OS.unkown
    end
  end

  def self.try_with_ver(conn)
    # ver => Microsoft Windows [Version 10.0.20348.469]
    command = "ver"
    conn.exec(command)

    identified = conn.ok && conn.last_output.include?("Windows")
    return GuessOS::OS.unkown unless identified

    output = conn.last_output
    begin
      output.tr!("\r", "")
      output.tr!("\n", "")
      items = output.split
      type = :windows
      name = "windows #{items[3].split(".").first}"
      desc = output
      GuessOS::OS.new(type, name, desc)
    rescue
      GuessOS::OS.unkown
    end
  end

  def self.try_with_folder(conn)
    # command = 'echo %windir%' => Windows
    command = "cd c:\windows"
    conn.exec(command)

    identified = conn.ok && conn.last_output.include?("Windows")
    return GuessOS::OS.unkown unless identified

    output = conn.last_output
    begin
      lines = output.split("\n")
      filter = lines.filter { _1.include? "Volume" }
      items = filter[0].split
      type = :windows
      name = items[-2, 2].join(" ").to_s
      desc = filter[0]
      GuessOS::OS.new(type, name, desc)
    rescue
      GuessOS::OS.unkown
    end
  end
end
