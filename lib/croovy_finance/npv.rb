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
    exp = 1.0
    sum = 0.0

    @payments.map do |pmt|
      pmt / ((1.0 + rate) ** exp).tap {exp += 1.0}
    end.reduce(:+)
  end

end
