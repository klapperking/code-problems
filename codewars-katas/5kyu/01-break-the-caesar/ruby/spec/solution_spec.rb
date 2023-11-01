# frozen_string_literal: true

require 'rspec'
require_relative '../src/solution'

describe('break_caesar') do
  describe 'solution' do
    it 'should identify the most likely shift' do
      expect(break_caesar('DAM?')).to eq(7)
      expect(break_caesar('Mjqqt, btwqi!')).to eq(5)
      expect(break_caesar('DAM? DAM! DAM.')).to eq(7)
      expect(break_caesar('Gur dhvpx oebja sbk whzcf bire gur ynml qbt.')).to eq(13)
    end
  end
end
