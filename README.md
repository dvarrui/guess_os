
# GuessOS

Try to guess the operating system installed on the host (local or remote). Using SSH to connect remote host.

**But, What about nmap?**

It is true that nmap already performs the function of finding out the OS. We didn't want to repeat the work of nmap. The idea of the gem is:

* Work without nmap installed. Its posible some host have not installed.
* nmap is fine but slow to return results. We wanted to integrate this functionality into another application and were not completely satisfied with the nmap response times.
* In an extension of this gem we are thinking that it will use of nmap to obtain the results when it is a remote machine and we do not have SSH access to it.

# Documentation

1. Install Ruby on your system.
1. `gem install --user-install guess_os`, to install gem as normal user.

> `sudo gem install --user-install guess_os`, to install gem as root user.

# Usage

> **WARNING**
>
> **guess_os** accepts several parameters (ip, username, password) to open an SSH connection to the remote host, and guess remote OS.
>
> In the case of writing IP="localhost" SSH is not used.

## Command

```console
❯ guess_os

[GuessOS]
      ip? localhost
    port?
username?
password?
--------------------------------------------------
  Type: gnulinux
  Name: opensuse
  Desc: Description: openSUSE Tumbleweed
```

## Gem

**localhost example**: Guess local host OS.

```ruby
require 'guess_os'

host = GuessOS::Host.new(ip: 'localhost')

puts host.os.type
puts host.os.name
```

**Remote host example**: Guess remote host OS. The connection is established via SSH.

```ruby
require 'guess_os'

host = GuessOS::Host.new(
  ip: '192.168.1.42',
  port: 2241,
  username: 'vagrant',
  password: 'vagrant'
)

puts host.os.type
puts host.os.name
```

> More [examples](examples)

Current OS list:

| OS type   | OS name  |
| --------- | -------- |
| :gnulinux | opensuse, debian, ubuntu, manjaro, mint |
| :windows  | windows |
| :macos    | macos   |
| :cygwin   | cygwin  |
| :minix    | minix   |
| :unkown   | unkown  |

# Contact

* **Email**: `teuton.software@protonmail.com`
