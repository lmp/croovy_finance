require_relative "irr"


class CroovyFinance::Apr

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
    CroovyFinance::Irr.new(payments).calc
  end


  private

  def payments
    [@loan_amount, *([@payment] * @periods)]
  end

end
