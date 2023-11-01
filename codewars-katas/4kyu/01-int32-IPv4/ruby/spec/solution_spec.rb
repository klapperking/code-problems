# frozen_string_literal: true

require 'rspec'
require_relative '../src/solution'

RSpec.describe('int32_to_ip') do
  it 'converts an unsigner 32bit integer into IP format string' do
    expect(int32_to_ip(2_154_959_208)).to eq('128.114.17.104')

    expect(int32_to_ip(0)).to eq('0.0.0.0')

    expect(int32_to_ip(2_149_583_361)).to eq('128.32.10.1')

    expect(int32_to_ip(1_299_946_083)).to eq('77.123.154.99')
  end
end
