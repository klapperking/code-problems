# frozen_string_literal: true

def break_caesar(message)
  # sanitize message
  message = message.split(' ').map { |word| word.downcase.gsub(/[^a-z]/, '')}
  alphabet = ('a'..'z').to_a

  match_count = {}

  (0...26).each do |shift|
    message.each do |word|

      shifted_word = word.chars.map { |char| alphabet[(alphabet.index(char) % 26 - shift)] }.join('')
      if WORDS.include?(shifted_word)
        match_count.key?(shift) ? match_count[shift] += 1 : match_count[shift] = 1
      end
    end
  end
  match_count.key(match_count.values.max)
end
