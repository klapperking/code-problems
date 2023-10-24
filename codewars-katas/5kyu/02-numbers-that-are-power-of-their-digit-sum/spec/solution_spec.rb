# frozen_string_literal: true

require 'rspec'
require_relative '../lib/solution'

describe('Solution') do
  it 'should find the n-th number in the sequence' do
    expect(power_sumDigTerm(1)).to eq(81)
  end
  it 'should find the n-th number in the sequence' do
    expect(power_sumDigTerm(2)).to eq(512)
  end
  it 'should find the n-th number in the sequence' do
    expect(power_sumDigTerm(3)).to eq(2401)
  end
  it 'should find the n-th number in the sequence' do
    expect(power_sumDigTerm(4)).to eq(4913)
  end
end
