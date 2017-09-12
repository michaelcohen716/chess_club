require_relative 'piece'
require_relative 'sliding_module'

class Bishop < Piece
  include SlidingPiece

  def initialize(player, position, board)
    super
  end

  def move_dirs
    return [[1,1],[-1,-1], [1,-1], [-1,1]]
  end

  def to_s
    "B"
  end

end
