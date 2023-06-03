require 'stackprof'

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

def base_possibilities(puzzle)
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

def is_possible?(puzzle, y, x, n)
  # check row and col
  (0..8).each { |i| return false if puzzle[y][i] == n || puzzle[i][x] == n }
  # check 3x3
  x0 = (x / 3).floor * 3
  y0 = (y / 3).floor * 3

  (0..2).each do |c|
    (0..2).each do |r|
      return false if puzzle[y0 + c][x0 + r] == n
    end
  end
  return true
end

def get_next_empty(puzzle)
  # iterate grid to find empty square
  (0..8).each do |i_row|
    (0..8).each do |i_col|
      return [i_row, i_col] if puzzle[i_row][i_col] == 0
    end
  end
  return nil
end

def get_last_filled_pos(puzzle)
  idx = puzzle.flatten.reverse.index { |n| !n.zero? }
  helper  = (idx / 9).floor
  return [helper - 1, idx - helper - 1]
end


def solve(puzzle, base_possibilities)
  # return if solved
  return puzzle unless puzzle.flatten.include?(0)

  # find next empty
  i_row, i_col = get_next_empty(puzzle)

  # attempt each possibility for given square
  base_possibilities["#{i_row}#{i_col}".to_sym].each do |n|
    # if possibility can still go into square, fill it and start recursion call
    if is_possible?(puzzle, i_row, i_col, n)
      puzzle[i_row][i_col] = n
      return puzzle if solve(puzzle, base_possibilities)

      # if future calls come back here, n was wrong, reset field and return
      puzzle[i_row][i_col] = 0

    end
  end
  return nil
end

# TODO Account for multiple solution sudokus.

puzzle = [[0, 0, 6, 1, 0, 0, 0, 0, 8],
          [0, 8, 0, 0, 9, 0, 0, 3, 0],
          [2, 0, 0, 0, 0, 5, 4, 0, 0],
          [4, 0, 0, 0, 0, 1, 8, 0, 0],
          [0, 3, 0, 0, 7, 0, 0, 4, 0],
          [0, 0, 7, 9, 0, 0, 0, 0, 3],
          [0, 0, 8, 4, 0, 0, 0, 0, 6],
          [0, 2, 0, 0, 5, 0, 0, 8, 0],
          [1, 0, 0, 0, 0, 2, 5, 0, 0]]

SOLUTION_COUNTER = 0

def sudoku_solver(puzzle)
  # raise Errors if invalid grid supplied
  raise StandardError.new("Invalid Grid") if puzzle.flatten.reject(&:zero?).size <= 17

  raise StandardError.new("Invalid Grid") if puzzle.flatten.any? { |x| x.negative? || x > 9 }

  raise StandardError.new("Invalid Grid") if puzzle.flatten.length != 81

  # initial pass to reduce possibilties
  base_possibilities = base_possibilities(puzzle)

  solve(puzzle, base_possibilities)
end

StackProf.run(mode: :cpu, out: 'stackprof.dump') do
  sudoku_solver(puzzle)
end


## TODO: Account for multiple solutions
