require "minitest/autorun"
require_relative "../../../lib/croovy"


class TestApr < Minitest::Unit::TestCase

  def test_apr
    apr = Croovy::Finance::Apr.new(360, 1_044.50, 238_650)
    result = apr.calc

    assert_in_delta 0.002745656227846, result, 0.0000001
  end

end
