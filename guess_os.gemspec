# frozen_string_literal: true

require_relative "lib/guess_os/version"

Gem::Specification.new do |spec|
  spec.name = "guess_os"
  spec.version = GuessOS::VERSION
  spec.summary = "Guess local or remote OS."
  spec.description = "Guess local or remote OS."

  spec.license = "GPL-3.0"
  spec.authors = ["David Vargas"]
  spec.email = ["dvarrui@protonmail.com"]
  spec.homepage = "https://github.com/dvarrui/guess_os"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  spec.extra_rdoc_files = ["README.md", "LICENSE"] \
                        + Dir.glob(File.join("docs", "**", "*.md"))

  spec.executables << "guess_os"
  spec.executables << "guess-os"
  spec.files = Dir.glob(File.join("lib", "**", "*.*"))
  spec.required_ruby_version = ">= 2.6.0"

  spec.add_runtime_dependency "net-ssh"
end
