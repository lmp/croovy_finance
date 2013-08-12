require "minitest/autorun"
require_relative "../../../lib/croovy"


class TestApr < Minitest::Unit::TestCase

  def test_apr
    apr = Croovy::Finance::Apr.new(360, 1_044.50, 238_650)
    result = apr.calc

    assert_in_delta 0.002745656227846, result, 0.0000001
  end

  def test_apr_vs_calculations_spreadsheet
    examples = [[360,	-1_410.71,	298_040,	0.03928971462724],
                [360,	-1_410.71,	300_000,	0.038749999999999],
                [360,	-1_410.71,	350_000,	0.026518363312251],
                [360,	-1_410.71,	450_000,	0.008211750221983],
                [360,	-1_410.71,	500_000,	0.001039187585303],
                [360,	-1_410.71,	250_000,	0.054440644135919],
                [360,	-1_410.71,	200_000,	0.075895349483349],
                [360,	-1_210.00,	298_040,	0.027073529837374],
                [360,	-1_610.71,	298_040,	0.050590153467513],
                [180,	-1_400.71,	150_000,	0.076193461467735],
                [48,	-200,	8_000,	0.092417669858425],
                [360,	-1_165.81,	236_282.5,	0.04274865450078],
                [360,	-1_013.37,	200_000,	0.044999947856313]]

    examples.each do |example|
      periods, payment, value, expected_times_12 = example

      result = Croovy::Finance::Apr.new(periods, payment, value).calc * 12

      assert_in_delta expected_times_12, result, 0.000001
    end
  end

end
