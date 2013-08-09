class Croovy::Finance::Npv

  # Calculate the Net Present Value of a time series of cash flows.
  #
  # payments: An array of cash flows
  #
  # See http://en.wikipedia.org/wiki/Net_present_value
  def initialize(payments)
    @payments = payments
    @one = 1.0
    @zero = 0.0
  end

  def call(rate)
    exp = 1.0
    sum = 0.0

    @payments.map do |pmt|
      pmt / ((@one + rate) ** exp).tap {exp += @one}
    end.reduce(:+)#.tap {|x| puts "npv: #{x.to_f}"}
  end

end
