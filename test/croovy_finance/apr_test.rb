require "minitest/autorun"
require_relative "../../lib/croovy_finance"


class TestApr < Minitest::Unit::TestCase

  def test_apr
    apr = CroovyFinance::Apr.new(360, 1_044.50, 238_650)
    result = apr.calc

    assert_in_delta 0.002745656227846, result, 1e-7
  end

  def test_edges
    edges = [[180, -191.25, 25_000.00, 0.044999999999998, 1e-5],
             [180, -349.90, 25_000.00, 0.15, 1e-5],
             [180, -149.62, 25_000.00, 0.009999999999999, 1e-5],
             [360, -126.67, 25_000.00, 0.044999999999122, 1e-5],
             [360, -316.11, 25_000.00, 0.15, 1e-5],
             [360, -80.41, 25_000.00, 0.009999999999996, 1e-6],
             [180, -11_474.90, 1_500_000.00, 0.044999999999998, 1e-6],
             [180, -20_993.81, 1_500_000.00, 0.15, 1e-6],
             [180, -8_977.42, 1_500_000.00, 0.009999999999999, 1e-6],
             [360, -7_600.28, 1_500_000.00, 0.044999999999122, 1e-6],
             [360, -18_966.66, 1_500_000.00, 0.15, 1e-6],
             [360, -4_824.59, 1_500_000.00, 0.009999999999996, 1e-6]]

    edges.each do |edge|
      periods, payment, value, expected_annual, delta = edge

      result = CroovyFinance::Apr.new(periods, payment, value).calc
      result_annual = result * 12

      assert_in_delta expected_annual, result_annual, delta, edge
    end
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
      periods, payment, value, expected_annual = example

      result = CroovyFinance::Apr.new(periods, payment, value).calc
      result_annual = result * 12

      assert_in_delta expected_annual, result_annual, 1e-6
    end
  end

end
