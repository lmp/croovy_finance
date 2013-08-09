require_relative "irr"


class Croovy::Finance::Apr

  # Calculate the APR for a loan
  #
  # The arguments are named to align with those of the RATE() function defined
  # in google spreadsheet. Namely,
  #
  # nper: Number of periods (ie payments) in the loan
  # pmt: The payment for the loan
  # pv: The present value of the loan (ie the loan amount)
  #
  # Unlike google spreadsheets, the sign of pmt and pv do not matter.
  def initialize(nper, pmt, pv)
    @periods = nper
    @payment = pmt.abs
    @loan_amount = pv.abs * -1
  end

  def calc
    Croovy::Finance::Irr.new(payments).calc
  end


  private

  def payments
    [@loan_amount, *([@payment] * @periods)]
  end

end


def main
  # [360, -1_410.71, 298_040, 209_817.05, 0.03928971462724],
  payments = [298_040, *([-1_410.71] * 360)]

  puts Apr.new(360, 1_410.71, 298_040).calc * 12
end

main if __FILE__ == $0
