require 'rspec'
require_relative '../src/spiralize'

RSpec.describe('spiralize') do
  it "does not accept input smaller 5" do
    expect(spiralize(2)).to raise_error(ArgumentError)
  end

  it "returns the correct spiral for inputs larger or equal to 5" do
    expect(spiralize(5)).to eq([
      [1,1,1,1,1],
      [0,0,0,0,1],
      [1,1,1,0,1],
      [1,0,0,0,1],
      [1,1,1,1,1]
      ])

    expect(spiralize(8)).to eq([
      [1,1,1,1,1,1,1,1],
      [0,0,0,0,0,0,0,1],
      [1,1,1,1,1,1,0,1],
      [1,0,0,0,0,1,0,1],
      [1,0,1,0,0,1,0,1],
      [1,0,1,1,1,1,0,1],
      [1,0,0,0,0,0,0,1],
      [1,1,1,1,1,1,1,1]
      ])
  end
end
