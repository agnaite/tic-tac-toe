class HumanPlayer
  attr_accessor :name, :mark, :board

  @mark = nil
  @grid_end = 2

  def initialize(name)
    @name = name
  end

  def get_move
    puts "Please enter position as 'x, y': "
    input = gets.chomp.delete(" ")
    move = move_valid?(input)
    return move if move
    puts "\nMove is invalid.\n"
    get_move
  end

  def display(board)
    @board = board
    cells = @board.grid

    cells =
      cells.map do |row|
        row.map do |cell|
          cell.nil?? ' ' : cell
        end
      end

    thing = <<-HEREDOC

        0      1     2
       _____ _____ _____
      |     |     |     |
    0 |  #{cells[0][0]}  |  #{cells[0][1]}  |  #{cells[0][2]}  |
      |_____|_____|_____|
      |     |     |     |
    1 |  #{cells[1][0]}  |  #{cells[1][1]}  |  #{cells[1][2]}  |
      |_____|_____|_____|
      |     |     |     |
    2 |  #{cells[2][0]}  |  #{cells[2][1]}  |  #{cells[2][2]}  |
      |_____|_____|_____|\n
    HEREDOC

    puts thing

  end

  private

  def move_valid?(move)
    if move.length == 3 && move.include?(",")
      move = move.split(",")
      (0..1).each { |i| move[i] = move[i].to_i }
      if move[0].between?(0, 2) && move[1].between?(0, 2)
        return [move[0], move[1]]
      end
    end
    return false
  end

end
