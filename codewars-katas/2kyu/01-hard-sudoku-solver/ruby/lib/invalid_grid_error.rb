# frozen_string_literal: true

class InvalidGridError < StandardError
  def initialize(message='Invalid Grid provided')
    super
  end
end
