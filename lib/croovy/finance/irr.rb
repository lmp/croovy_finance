require_relative "secant"
require_relative "npv"


class Croovy::Finance::Irr

  # Calculate the Internal Rate of Return for a loan
  #
  # It is assumed that outflows will be < 0, while inflows will be > 0.
  #
  # See http://en.wikipedia.org/wiki/Internal_rate_of_return
  def initialize(payments)
    @payments = payments
  end

  def calc
    Secant.new(@payments).solve(npv, r_1, r_2)
  end


  private

  def npv
    @npv ||= NetPresentValue.new(@payments)
  end

  def r_1
    cap_a_over_abs_cap_c_0 ** (2 / @payments.size.to_f) - 1
  end

  def r_2
    (1 + r_1) ** p - 1
  end

  def cap_a_over_abs_cap_c_0
    cap_a / abs_c_0
  end

  def cap_a
    @payments[1..-1].reduce(:+)
  end

  def abs_c_0
    @payments[0].abs
  end

  def p
    Math.log(cap_a_over_abs_cap_c_0) /
      Math.log(cap_a / npv_1_in.call(r_1))
  end

  def npv_1_in
    @npv_1_in ||= NetPresentValue.new(@payments[1..-1])
  end

end


def main
  # [360, -1_410.71, 298_040, 209_817.05, 0.03928971462724],
  payments = [-298_040, *([1_410.71] * 360)]

  puts Irr.new(payments).calc * 12
end

main if __FILE__ == $0
