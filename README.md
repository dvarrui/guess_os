
# GuessOS

Try to guess the operating system installed on the host (local or remote)

# Documentation

1. Install Ruby on your system.
1. `gem install --user-install guess_os`, to install gem.

# Usage

```ruby
require 'guess_os'

host = GuessOS::Host.new(
  ip: 'localhost',
  port: 2241,
  username: 'vagrant',
  password: 'vagrant'
)

puts host.os
```

# Contact

* **Email**: `teuton.software@protonmail.com`