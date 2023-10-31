# frozen_string_literal: true

require_relative 'number_finder'

def find_all(sum, n_digits)
  number_finder = NumberFinder.new(sum, n_digits)
  number_finder.find_numbers

  return number_finder.summary
end

p find_all(10,3)
