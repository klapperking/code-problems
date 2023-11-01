# frozen_string_literal: true

require 'rspec'
require_relative '../src/solution'

# define two test puzzles
puzzle = [[0, 0, 6, 1, 0, 0, 0, 0, 8],
          [0, 8, 0, 0, 9, 0, 0, 3, 0],
          [2, 0, 0, 0, 0, 5, 4, 0, 0],
          [4, 0, 0, 0, 0, 1, 8, 0, 0],
          [0, 3, 0, 0, 7, 0, 0, 4, 0],
          [0, 0, 7, 9, 0, 0, 0, 0, 3],
          [0, 0, 8, 4, 0, 0, 0, 0, 6],
          [0, 2, 0, 0, 5, 0, 0, 8, 0],
          [1, 0, 0, 0, 0, 2, 5, 0, 0]]

puzzle2 = [[8, 0, 0, 0, 0, 0, 0, 0, 0],
           [0, 0, 3, 6, 0, 0, 0, 0, 0],
           [0, 7, 0, 0, 9, 0, 2, 0, 0],
           [0, 5, 0, 0, 0, 7, 0, 0, 0],
           [0, 0, 0, 0, 4, 5, 7, 0, 0],
           [0, 0, 0, 1, 0, 0, 0, 3, 0],
           [0, 0, 1, 0, 0, 0, 0, 6, 8],
           [0, 0, 8, 5, 0, 0, 0, 1, 0],
           [0, 9, 0, 0, 0, 0, 4, 0, 0]]


describe('sudoku_solver') do
  describe ('Solving puzzles') do
    it ('should find the solution to an easy sudoku puzzle') do
      expect(sudoku_solver(puzzle)).to eq([[3, 4, 6, 1, 2, 7, 9, 5, 8],
                                            [7, 8, 5, 6, 9, 4, 1, 3, 2],
                                            [2, 1, 9, 3, 8, 5, 4, 6, 7],
                                            [4, 6, 2, 5, 3, 1, 8, 7, 9],
                                            [9, 3, 1, 2, 7, 8, 6, 4, 5],
                                            [8, 5, 7, 9, 4, 6, 2, 1, 3],
                                            [5, 9, 8, 4, 1, 3, 7, 2, 6],
                                            [6, 2, 4, 7, 5, 9, 3, 8, 1],
                                            [1, 7, 3, 8, 6, 2, 5, 9, 4]])
    end

    it ('should find the solution to a hard sudoku puzzle') do
      expect(sudoku_solver(puzzle2)).to eq([[8, 1, 2, 7, 5, 3, 6, 4, 9],
                                            [9, 4, 3, 6, 8, 2, 1, 7, 5],
                                            [6, 7, 5, 4, 9, 1, 2, 8, 3],
                                            [1, 5, 4, 2, 3, 7, 8, 9, 6],
                                            [3, 6, 9, 8, 4, 5, 7, 2, 1],
                                            [2, 8, 7, 1, 6, 9, 5, 3, 4],
                                            [5, 2, 1, 9, 7, 4, 3, 6, 8],
                                            [4, 3, 8, 5, 2, 6, 9, 1, 7],
                                            [7, 9, 6, 3, 1, 8, 4, 5, 2]])
    end
  end

  describe ('Detecting wrong inputs') do
    it ('should identify invalid formats') do
      expect { sudoku_solver([]) }.to raise_error(InvalidGridError)

      puzzle[0][0] = 10
      expect { sudoku_solver(puzzle) }.to raise_error(InvalidGridError)
    end

    it ('should identify unsolvable ones') do
      expect { sudoku_solver(Array.new(9, Array.new(9,0))) }.to raise_error(InvalidGridError)
    end

    it ('should identify puzzles with multiple solutions') do
      puzzle2[8][1] = 0
      puzzle2[8][5] = 0
      expect { sudoku_solver(puzzle2) }.to raise_error(InvalidGridError)
    end
  end
end

# additionally do profiling
# StackProf.run(mode: :cpu, out: 'stackprof.dump') do
#   sudoku_solver(puzzle2)
# end
