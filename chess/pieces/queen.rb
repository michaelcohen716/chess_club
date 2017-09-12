require_relative 'piece'
require_relative 'sliding_module'

class Queen < Piece
  include SlidingPiece

  def initialize(player, position, board)
    super
  end

  def move_dirs
    return [[1,1],[-1,-1], [1,-1], [-1,1],[0,1],[0,-1], [1,0], [-1,0]]
  end

  def to_s
    if self.player == :white
      "\u2655".encode('utf-8')
    else
      "\u265B".encode('utf-8')
    end
  end

end
