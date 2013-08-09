require "minitest/autorun"
require_relative "../../../lib/croovy"


class TestNpv < Minitest::Unit::TestCase

  def test_npv
    npv = Croovy::Finance::Npv.new([-100_000,
                                    -54_672,
                                    -39_161,
                                    3_054,
                                    7_128,
                                    25_927,
                                    28_838,
                                    46_088,
                                    77_076,
                                    46_726,
                                    76_852,
                                    132_332,
                                    166_047])

    assert_in_delta 59_832.766488911, npv.call(0.1), 0.0000000001
  end

end
