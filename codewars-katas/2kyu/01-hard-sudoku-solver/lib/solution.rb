# frozen_string_literal: true

require_relative 'sudoku_solver'
require_relative 'invalid_grid_error'

def sudoku_solver(puzzle)
  # Guard clause Errors for various invalids (too lttle info, invalid entries, wrong format)
  raise InvalidGridError, 'Invalid Grid - Less than 17 given' if puzzle.flatten.reject(&:zero?).size <= 17

  raise InvalidGridError, 'Invalid Grid - Invalid numbers in grid' if puzzle.flatten.any? { |x| x.negative? || x > 9 }

  raise InvalidGridError, 'Invalid Grid - Wrong format' if puzzle.flatten.length != 81

  solver = SudokuSolver.new(puzzle)
  solver.find_solution()
  return solver.solution
end
