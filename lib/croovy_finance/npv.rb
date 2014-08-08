class CroovyFinance::Npv

  # Calculate the Net Present Value of a time series of cash flows.
  #
  # payments: An array of cash flows as floats
  #
  # See http://en.wikipedia.org/wiki/Net_present_value
  def initialize(payments)
    @payments = payments
  end

  def call(rate)
    factor = 1.0 + rate
    accum_factor = 1.0

    @payments.inject(0.0) do |result, pmt|
      result + pmt / (accum_factor *= factor)
    end
  end

end
