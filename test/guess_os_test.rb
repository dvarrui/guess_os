# frozen_string_literal: true

require "test_helper"

class GuessOsTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::GuessOs.const_defined?(:VERSION)
    end
  end

  test "something useful" do
    assert_equal("expected", "actual")
  end
end
