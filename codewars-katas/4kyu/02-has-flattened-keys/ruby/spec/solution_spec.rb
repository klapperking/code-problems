# frozen_string_literal: true

require 'rspec'
require_relative '../src/solution'

RSpec.describe('flattened_keys') do
  unflat = { a: 1, 'b' => 2, info: { id: 1, 'name' => 'example' } }

  it 'should flatten keys on one level' do
    expect(unflat.flattened_keys).to eq({ a: 1, 'b' => 2, info_id: 1, 'info_name' => 'example' })
  end

  it 'should maintain the higher order symbol' do
    expect(unflat.flattened_keys.keys).to include('info_name')

    expect(unflat.flattened_keys.keys).to include('b')
  end
end
