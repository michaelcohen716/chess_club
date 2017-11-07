require 'singleton'

class Piece
  attr_reader :player, :board
  attr_accessor :position

  def initialize(player, position, board)
    @player = player
    @position = position
    @board = board

  end

  def to_s
    "P"
  end

  def valid_moves
    self.moves.reject {|end_pos| self.move_into_check?(end_pos)}
  end

  def move_into_check?(end_pos)
    dup_board = self.board.dup_board

    dup_board.move_piece!(self.position, end_pos)

    dup_board.in_check?(self.player)
  end

  def eval_other_piece(other_piece)
    if other_piece.class == NullPiece
      return "Null"
    elsif other_piece.player == self.player
      return "Same Player"
    else
      return "Other Player"
    end
  end
end

class NullPiece < Piece
  include Singleton

  def initialize

  end

  def to_s
    " "
  end
end
