require 'stackprof'

class SudokuSolver
  attr_reader :solution, :solution_counter

  def initialize(puzzle)
    # init with a 2d-array of puzzle
    @puzzle = puzzle
    @solution = nil
    @solution_counter = 0
  end

  def find_solution
    # initial pass to reduce fill-possibilities
    @base_possibilities = get_base_possibilites(@puzzle)

    # solve for a solution
    solve()

    # exit if unsolvable
    raise 'Unsolvable' unless @solution
  end

  private

  def get_base_possibilites(puzzle)
    # pass entire grid once and remove possibilities for each square based on pre-fill
    possibilities = {}
    (0..8).each do |i_row|
      (0..8).each do |i_col|
        next unless puzzle[i_row][i_col].zero?

        possibilities["#{i_row}#{i_col}".to_sym] = [1, 2, 3, 4, 5, 6, 7, 8, 9]

        (0..8).each do |i|
          possibilities["#{i_row}#{i_col}".to_sym].delete(puzzle[i_row][i])
          possibilities["#{i_row}#{i_col}".to_sym].delete(puzzle[i][i_col])
        end

        get_square(i_row, i_col).each { |i| possibilities["#{i_row}#{i_col}".to_sym].delete(puzzle[i[0]][i[1]]) }
      end
    end
    return possibilities
  end

  def get_next_empty(prev_row = nil)
    # iterate grid to find empty square
    prev_row ||= 0

    # Update this! 0,8 jumps to 1, 8 (instead of 1, 1) -- Fix! ; DK how to fix that;
    # Input is [0, 8] , go to [1, 0] and continue - how?
    (prev_row..8).each do |i_row|
      (0..8).each do |i_col|
        return [i_row, i_col] if @puzzle[i_row][i_col] == 0
      end
    end
    return nil
  end

  def is_possible?(y, x, n)
    # check row and col
    (0..8).each { |i| return false if @puzzle[y][i] == n || @puzzle[i][x] == n }

    # check 3x3
    x0 = (x / 3).floor * 3
    y0 = (y / 3).floor * 3

    (0..2).each do |c|
      (0..2).each do |r|
        return false if @puzzle[y0 + c][x0 + r] == n
      end
    end
    return true
  end

  def get_square(y, x)
    y0 = (y / 3) * 3
    x0 = (x / 3) * 3

    pos = []
    (0..2).each do |i_row|
      (0..2).each do |i_col|
        pos.push([y0 + i_row, x0 + i_col])
      end
    end
    return pos
  end

  def filled?(puzzle)
    puzzle.reverse.each do |row|
      row.each do |num|
        return false if num.zero?
      end
    end
    return true
  end

  def solve(prev_row = nil)
    # if solution found, continue searching
    if filled?(@puzzle)
      # increment solution_counter
      @solution_counter += 1

      # solve is found - check if mulitple solutions exit
      raise 'Invalid Grid - Multiple Solutions' if @solution_counter > 1

      # keep solution
      @solution = Marshal.load(Marshal.dump(@puzzle))

      # remove last filled number from grid and the positions possibilities, then continue

      last_filled_idx = @base_possibilities.keys.last
      active_number = @puzzle[last_filled_idx[0].to_i][last_filled_idx[1].to_i]

      @base_possibilities[last_filled_idx].delete(active_number)
      @puzzle[last_filled_idx[0].to_i][last_filled_idx[1].to_i] = 0
    end

    # find next empty
    i_row, i_col = get_next_empty(prev_row)

    # attempt each possibility for given square
    @base_possibilities["#{i_row}#{i_col}".to_sym].each do |n|
      # if possibility can still go into square, fill it and start recursion call
      if is_possible?(i_row, i_col, n)
        @puzzle[i_row][i_col] = n
        return true if solve(prev_row = i_row)

        # if future calls come back here, n was wrong, reset field and return
        @puzzle[i_row][i_col] = 0
      end
    end
    return false
  end
end

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

def sudoku_solver(puzzle)
  # Guard clause Errors for various invalids (too lttle info, invalid entries, wrong format)
  raise 'Invalid Grid - Less than 17 given' if puzzle.flatten.reject(&:zero?).size <= 17

  raise 'Invalid Grid - Invalid numbers in grid' if puzzle.flatten.any? { |x| x.negative? || x > 9 }

  raise 'Invalid Grid - Wrong format' if puzzle.flatten.length != 81

  solver = SudokuSolver.new(puzzle)
  solver.find_solution()
  return solver.solution
end

StackProf.run(mode: :cpu, out: 'stackprof.dump') do
  sudoku_solver(puzzle2)
end

# TODO: Refactor for faster solve (esp. for lower amounts of given)
# Option 1: Major Refactor: Update Possibilty Hash on every filled number to exit faster
# Option 2: Optimize performance somewhat faster using profiling
# Option 3: Implement 'Human Logic' to solve after threshold of filled nums
