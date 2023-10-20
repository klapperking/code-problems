# frozen_string_literal: true

def solution(cross_sum, n_digits)
  # guard for impossibles, eg. 3 digits and cross_sum 20
  return [] if ((9 * n_digits) <= cross_sum) || ((1 * n_digt) >= cross_sum)

  return [result.size, result.first, result.last]
end
