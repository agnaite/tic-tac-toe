class Board
  attr_accessor :grid

  def initialize(grid = default_grid)
    @grid = grid
    @winner = nil
  end

  def place_mark(position, mark)
    unless over?
      x, y = position[0], position[1]
      @grid[x][y] = mark if empty?(position)
      over?
    end
  end

  def empty?(position)
    x, y = position[0], position[1]
    return @grid[x][y]::nil?
  end

  def winner
    @winner
  end

  def over?
    (0...@grid.count).each do |count|
      if row_winners?(count) || column_winners?(count) || diagonal_winners?
        return true
      else
        @winner = nil
      end
    end
    arr = @grid[0] + @grid[1] + @grid[2]
    return arr.all?
  end

  def row_winners?(y)
    @grid[y].all? { |square| @winner = :X if square == :X } ||
    @grid[y].all? { |square| @winner = :O if square == :O }
  end

  def column_winners?(x)
    @grid.all? { |square| @winner = :X if square[x] == :X } ||
    @grid.all? { |square| @winner = :O if square[x] == :O }
  end

  def diagonal_winners?
    down = []
    up = []

    (0...@grid.length).each do |count|
      down << @grid[0 + count][0 + count]
      up << @grid[0 + count][(@grid.length - 1) - count]
    end

    (up.all? { |square| @winner = :X if square == :X } ||
     up.all? { |square| @winner = :O if square == :O }) ||
    (down.all? { |square| @winner = :X if square == :X } ||
     down.all? { |square| @winner = :O if square == :O })
  end

  private

  def default_grid
    [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
  end
end
