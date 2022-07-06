
# GuessOS

Try to guess the operating system installed on the host (local or remote)

# Documentation

1. Install Ruby on your system.
1. `gem install --user-install guess_os`, to install gem.

# Usage

Guess local host OS:
```ruby
require 'guess_os'

host = GuessOS::Host.new(ip: 'localhost')

puts host.os.type
puts host.os.name
```

Guess remote host OS:
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
| gnu/linux | opensuse |
| gnu/linux | debian  |
| gnu/linux | ubuntu  |
| gnu/linux | manjaro |
| cygwin    | cygwin  |
| windows   | windows |
| minix     | minix   |
| unkown    | unkown  |

# Contact

* **Email**: `teuton.software@protonmail.com`




