def power_sumDigTerm(n)

  series = [0]

  1000.times do |number|
    20.times do |power|

      result = number**power

      series << result if result > 9 && result.digits.sum == number
    end
  end

  series.sort[n]
end

p power_sumDigTerm(1)
