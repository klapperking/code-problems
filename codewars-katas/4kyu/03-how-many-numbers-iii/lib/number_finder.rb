# frozen_string_literal: true

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

    return [@result.size, @result.first, @result.last]
  end


  """
  [1,1,1] -> prev = 0, sum = sum - prev = 10, n_digits = 3
  [1,1] -> prev = prev + 1 = 1, sum = sum - prev = 9, n_digits = 2
  [1]; prev = prev + 1 = 2, sum = sum - prev = 8, n_digits = 1
  n_digits 1 reached: set to 8 --> reuslt 1,1,8 : CONDITION: Last Digit and sum is possible, what if its not possible
  append to result
  change last num AND THE ONE BEFORE to += 1 and move back one call

  [2,2] -> prev = 1, sum - prev = 9, n_digits = 2
  [2] -> prev = prev + 2 = 3, sum = sum - prev = 7    add to result: 1,2,7

  [3,3]

  etc
  """

  def find_numbers(sum=@sum, number=@number, n_digits=@n_digits, prev=0)
    # guard impossible inputs
    return if sum < 1 || n_digits < 1

    # exit recursion when max number is reached
    return if @number.sum == @n_digits * 9

    # check: Can sum - previous be built with n_digits?
    if (sum - prev) <= (n_digits * 9)

      # check if we are at last digit
      if n_digits == 1

        # if so, make the number, add it to the results and prepare for further search
        @number[-1] = sum
        @result.push(@number.join.to_i)

        # attempt to increase the previous number by one, unless it is 9 then move the the previous again
        to_check = -1
        loop do
          if @number[to_check - 1] < 9
            @number[to_check - 1] += 1
            @number[to_check..] = @number[to_check - 1]
            break
          end
          to_check -= 1
        end

        # after adjusting number start backtracking
        number = @number[(to_check - 1)..]
        n_digits += (to_check * (-1))
        prev = @number[..to_check-1].sum
      end
      # if more than 1 digit is left, move one digit right
      prev += number[0]
      number = number[1..]
      return find_numbers(sum = @sum - prev, number=number, n_digits -= 1, prev)
    end
  end
end
