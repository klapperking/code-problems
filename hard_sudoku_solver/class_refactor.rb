class SudokuSolver
  attr_reader :solution, :solution_counter

  def initialize(puzzle)
    # init with a 2d-array of puzzle
    @puzzle = puzzle
    @solution = nil
    @solution_counter = 0
    find_solution()
  end

  def find_solution
    # Guard clause Errors for various invalids (too lttle info, invalid entries, wrong format)
    raise 'Invalid Grid - Less than 17 given' if @puzzle.flatten.reject(&:zero?).size <= 17

    raise 'Invalid Grid - Invalid numbers in grid' if @puzzle.flatten.any? { |x| x.negative? || x > 9 }

    raise 'Invalid Grid - Wrong format' if @puzzle.flatten.length != 81

    # initial pass to reduce fill-possibilities
    @base_possibilities = get_base_possibilites(@puzzle)

    # solve for a solution
    solve()

    # exit if unsolvable
    return nil unless @solution

    # solve is found - check if mulitple solutions exit
    raise 'Invalid Grid - Multiple Solutions' if @solution_counter > 1

    return @solution
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

  def get_next_empty
    # iterate grid to find empty square
    (0..8).each do |i_row|
      (0..8).each do |i_col|
        return [i_row, i_col] if @puzzle[i_row][i_col] == 0
      end
    end
    return nil
  end

  def get_last_filled_pos()
    # read puzzle from the back to get idx of first non-zero number
    idx = 63 - @puzzle.flatten.reverse.index { |n| !n.zero? }

    # row of original puzzle
    row = (idx / 9).floor + 1
    col = idx - (row - 1) * 9 + 8

    return [row, col]
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

  def solve
    # if solution found, continue searching
    unless @puzzle.flatten.include?(0)
      # increment solution_counter
      @solution_counter += 1

      # keep solution
      @solution = Marshal.load(Marshal.dump(@puzzle))

      # remove last non-zero from grid and from the possibility hash # TODO Does it need to added elsewhere? (No?)
      i_row, i_col = get_last_filled_pos()
      @base_possibilities["#{i_row}#{i_col}".to_sym]&.delete(@puzzle[i_row][i_col])
      @puzzle[i_row][i_col] = 0
      return true
    end
    # find next empty
    i_row, i_col = get_next_empty()

    # attempt each possibility for given square
    @base_possibilities["#{i_row}#{i_col}".to_sym].each do |n|
      # if possibility can still go into square, fill it and start recursion call
      if is_possible?(i_row, i_col, n)
        @puzzle[i_row][i_col] = n
        return true if solve()

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


solver = SudokuSolver.new(puzzle)

solver.find_solution()
