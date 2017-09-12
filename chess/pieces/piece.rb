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

  def moves
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
  def initialize

  end

  def to_s
    " "
  end
end
