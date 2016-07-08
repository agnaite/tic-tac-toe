$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

require 'board'
require 'human_player'
require 'computer_player'

class Game
  attr_accessor :board, :player_one, :player_two, :current_player

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @player_one.mark = :X
    @player_two.mark = :O
    @current_player = @player_one
    @board = Board.new
  end

  def play
    @current_player.display(@board)
    while !@board.over?
      play_turn
      @current_player.display(@board)
    end
    switch_players!
    puts "\nThe winner is: #{@current_player.name}\n"
  end

  def play_turn
    move = @current_player.get_move
    x, y = move[0], move[1]
    if !@board.empty?([x.to_i, y.to_i])
      puts "Square is not empty."
      play
    end
    @board.place_mark(move, @current_player.mark)
    switch_players!
  end

  def switch_players!
    if @current_player == @player_one
      @current_player = @player_two
    else
      @current_player = @player_one
    end
  end
end
