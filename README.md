
# GuessOS

Try to guess the operating system installed on the host (local or remote)

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
❯ ./bin/guess_os
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
