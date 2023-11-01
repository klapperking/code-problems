# frozen_string_literal: true

require 'rspec'
require_relative '../src/solution'

describe('How many numbers') do
  describe('Sanity Tests') do
    it 'should return an array of integer' do
      expect(find_all(10, 3).class).to eq(Array)
      expect(find_all(10, 3).all? { |el| el.is_a?(Integer) }).to be true
    end
  end

  describe('Test Cases') do
    it 'should find the right numbers' do
      expect(find_all(10, 3)).to eq([8, 118, 334])
      expect(find_all(27, 3)).to eq([1, 999, 999])
      expect(find_all(84, 4)).to eq([])
      expect(find_all(35, 6)).to eq([123, 116_999, 566_666])
    end
  end
end
