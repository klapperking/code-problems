# frozen_string_literal: true

def int32_to_ip(int32)
  # guard for exception case
  return '0.0.0.0' if int32.zero?

  bin_str = int32.to_s(2)

  last_num = bin_str[-8..].to_i(2).to_s
  third_num = bin_str[-16..-9].to_i(2).to_s
  second_num = bin_str[-24..-17].to_i(2).to_s
  first_num = bin_str[..-25].to_i(2).to_s

  "#{first_num}.#{second_num}.#{third_num}.#{last_num}"
end
