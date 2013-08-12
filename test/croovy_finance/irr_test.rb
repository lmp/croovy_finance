require "minitest/autorun"
require_relative "../../lib/croovy_finance"


class TestIrr < Minitest::Unit::TestCase

  def test_irr
    irr = CroovyFinance::Irr.new([-4_000,
                                  1200,
                                  1410,
                                  1875,
                                  1050,])
    result = irr.calc(0.25, 0.2)

    assert_in_delta 0.142, result, 0.001
  end

end
