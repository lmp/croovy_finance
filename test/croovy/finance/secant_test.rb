require "minitest/autorun"
require_relative "../../../lib/croovy"


class TestSecant < Minitest::Unit::TestCase

  def test_secant
    callable = proc {|x|
      x ** 2.0 - 612
    }
    secant = Croovy::Finance::Secant.new
    result = secant.solve(callable, 30.0, 10.0)

    assert_in_delta 24.7386, result, 0.0001
  end

end
