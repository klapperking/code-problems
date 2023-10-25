# frozen_string_literal: true

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

desc('Checking for style offenses')
task(:rubocop) do
  sh 'rubocop --format simple || true'
end

task default: %i[rubocop spec]
