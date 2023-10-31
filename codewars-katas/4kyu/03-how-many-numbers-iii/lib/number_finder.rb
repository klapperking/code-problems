# frozen_string_literal: true

# Finds all numbers that satisfy kata requirements
class NumberFinder
  def initialize(sum, n_digits)
    @number = Array.new(n_digits, 1)
    @sum = sum
    @n_digits = n_digits
    @result = []
  end

  def summary
    # if no numbers are possible, return empty result array
    return @result if @result.empty?

    return [@result.size, @result.min, @result.max]
  end

  def find_numbers(candidate = '', remaining_sum = @sum, remaining_count = @n_digits, last_digit = 1)
    # early exits when impossible
    return if remaining_sum > remaining_count * 9

    # exit condition, sum is reached with no digits remaining
    if remaining_count.zero? && remaining_sum.zero?
      @result << candidate.to_i
      return
    end

    # starting at last digit, can the sum be built with the remaining digits?
    (last_digit..9).each do |digit|
      if remaining_sum - digit >= 0
        find_numbers(candidate + digit.to_s, remaining_sum - digit, remaining_count - 1, digit)
      end
    end
  end
end
