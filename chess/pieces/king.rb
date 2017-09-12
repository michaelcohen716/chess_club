require_relative 'piece'
require_relative 'stepping_module'

class King < Piece
  include SteppingPiece

  def initialize(player, position, board)
    super
  end

  def move_steps
    [[1,1],[-1,-1], [1,-1], [-1,1],[0,1],[0,-1], [1,0], [-1,0]]
  end

  def to_s
    "K"
  end
end
