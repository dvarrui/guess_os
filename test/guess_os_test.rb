# frozen_string_literal: true

require "test_helper"
require "guess_os/version"

class GuessOSTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::GuessOS.const_defined?(:VERSION)
    end
  end
end
