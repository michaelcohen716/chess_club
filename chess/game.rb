require 'byebug'

require_relative "board"
require_relative "display"
require_relative "human_player"


class Game

  attr_accessor :player1, :player2, :current_player, :previous_player, :board
  attr_accessor :display

  def initialize(board, player1, player2)
    @board, @player1, @player2 = board, player1, player2
    @current_player = player1
    @previous_player = nil
    @display = Display.new(board)
  end

  def play
    self.display.render
    until game_over?
      self.current_player.play_turn(display, board)
      self.switch_players
      self.display.render
    end
    puts "#{self.current_player.color} is in checkmate. #{self.previous_player.color} is the winner!"
  end

  # def play_turn
  #   start_pos = nil
  #   end_pos = nil
  #
  #   until !start_pos.nil? && !end_pos.nil?
  #     self.current_player.get_input
  #   end
  # end

  def switch_players
    if self.current_player == self.player1
      self.current_player = self.player2
      self.previous_player = self.player1
    else
      self.current_player = self.player1
      self.previous_player = self.player2
    end
  end

  def game_over?
    @board.checkmate?(@current_player.color)
  end


end

if __FILE__ == $PROGRAM_NAME
  board = Board.standard_board
  player1 = HumanPlayer.new("White", :white)
  player2 = HumanPlayer.new("Black", :black)
  game = Game.new(board, player1, player2)
  game.play
end
