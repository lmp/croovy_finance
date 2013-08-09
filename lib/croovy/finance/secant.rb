class Croovy::Finance::Secant

  # Calculate the root of a function
  #
  # proc: A callable object, representing the function whose root you wish to
  #       find
  # r_1: Initial guess of the root
  # r_2: Second initial guess of the root
  #
  # See http://en.wikipedia.org/wiki/Secant_method
  #     http://mathworld.wolfram.com/SecantMethod.html
  def initialize(convergence_difference=0.0000001)
    @convergence_difference = convergence_difference
  end

  def iterate(proc, n_1, n_2)
    fn_1 = proc.call(n_1)
    fn_2 = proc.call(n_2)

    # $stderr.puts "n_1: %p" % [n_1]
    # $stderr.puts "n_2: %p" % [n_2]
    # $stderr.puts "fn_1: %p" % [fn_1]
    # $stderr.puts "fn_2: %p" % [fn_2]

    (n_1 - fn_1 * ((n_1 - n_2) / (fn_1 - fn_2))).tap do |n|
      # $stderr.puts "n: %f" % [n]
    end
  end

  def solve(proc, n_1, n_2, iterations=10_000)
    iterations.times do |x|
      n_2, n_1 = [n_1, iterate(proc, n_1, n_2)]
      break if n_1.infinite? || converged?(n_1, n_2)
    end

    n_1.infinite? ? n_2 : n_1
  end


  private

  def converged?(value1, value2)
    (value1 - value2).abs < @convergence_difference
  end

end
