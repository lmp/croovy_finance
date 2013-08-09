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

  def calc(r_1=nil, r_2=nil)
    r_1 ||= r_1_guess
    r_2 ||= r_2_guess

    Croovy::Finance::Secant.new.solve(npv, r_1, r_2)
  end


  private

  def npv
    @npv ||= Croovy::Finance::Npv.new(@payments)
  end

  def r_1_guess
    cap_a_over_abs_cap_c_0 ** (2 / @payments.size.to_f) - 1
  end

  def r_2_guess
    (1 + r_1_guess) ** p - 1
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
      Math.log(cap_a / npv_1_in.call(r_1_guess))
  end

  def npv_1_in
    @npv_1_in ||= Croovy::Finance::Npv.new(@payments[1..-1])
  end

end
