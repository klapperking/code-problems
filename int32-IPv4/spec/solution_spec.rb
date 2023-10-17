# frozen_string_literal: true

require 'rspec'
require_relative '../lib/solution'

RSpec.describe('int32_to_ip') do
  it 'converts an unsigner 32bit integer into IP format string' do
    expect(int32_to_ip(2_154_959_208)).to equal('128.114.17.104')

    expect(int32_to_ip(0)).to equal('0.0.0.0')

    expect(int32_to_ip(2_149_583_361)).to equal('128.32.10.1')
  end
end
