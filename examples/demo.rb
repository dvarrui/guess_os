#!/usr/bin/env ruby

require_relative '../lib/remote-os/demo'

# 2211 win10 | /cygdrive/c/Users/vagrant
# 'lsb_release -d'
# 2231 => opensuse | openSUSE_Leap_15.3
# 2241 => debian   | Debian_GNU/Linux_10_(buster)
# 2242 => unkown UBUNTU!!!
# 2251 => manjaro  | Manjaro_Linux
# 2252 => mimix3 | Manjaro_Linux

ports = { 
  win10: '2211',     winserver: '2221',
  opensuse: '2231',
  debian: '2241',    ubuntu: '2242',
  manjaro: '2251',   minix: '2252'
}

osname = ARGV.first
if osname.nil?
  puts "Opciones : #{ports.keys.sort.join(', ').to_s}"
  exit 1
end

osname = osname.to_sym
remote_host = Demo.new(
  ip: 'localhost',      
  port: ports[osname],
  username: 'vagrant',  
  password: 'vagrant'
)

commands = { 
  win10: 'pwd',
  winserver: 'echo %windir%',
  opensuse: 'lsb_release -d',
  debian: 'lsb_release -d',
  ubuntu: 'lsb_release -d',
  manjaro: 'lsb_release -d',
  minix: 'cat /etc/motd |grep MINIX'
}

position = {
  win10: 0,
  winserver: 0,
  opensuse: 1,
  debian: 1,
  ubuntu: 1,
  manjaro: 1,
  minix: 7
}

remote_host.guess_type(
  command: commands[osname],
  position: position[osname]
)

remote_host.show_info
