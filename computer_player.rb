class ComputerPlayer
  attr_accessor :board, :mark, :name

  @mark = nil

  def initialize(name)
    @name = name
  end

  def display(board)
    @board =  board
  end

  def get_move
    @board.grid.each_with_index do |row, column|
      if row.count(@mark) > 1
        blank = row.index(nil) #find empty square on that row
        return pos = [column, blank]
      end
      match = 0
      (0...@board.grid.length).each do |square|
        match += 1 if @board.grid[square][column] == @mark
        blank = square if @board.grid[square][column]::nil?
        if match > 1
          blank = @board.grid.length - 1 if blank::nil?
          return pos = [blank, column]
        end
      end # end of inner loop
    end # end of outer loop
    return diagonal_win? if diagonal_win? != false
    random_move
  end

  private
  def random_move
    pos = [1, 1]
    while !@board.empty?(pos)
      x = rand(0...@board.grid.length)
      y = rand(0...@board.grid.length)
      pos = [x, y]
    end
    pos
  end

  def diagonal_win?
    down = [@board.grid[0][0], @board.grid[1][1], @board.grid[2][2]]
    up = [@board.grid[0][2], @board.grid[1][1], @board.grid[2][0]]

    if down.count(@mark) > 1
      return [0, 0] if @board.grid[0][0].nil?
      return [1, 1] if @board.grid[1][1].nil?
      return [2, 2] if @board.grid[2][2].nil?
    end
    if up.count(@mark) > 1
      return [0, 2] if @board.grid[0][2].nil?
      return [1, 1] if @board.grid[1][1].nil?
      return [2, 0] if @board.grid[2][0].nil?
    end
    return false
  end
end
