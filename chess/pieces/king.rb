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
    if self.player == :white
      "\u2654".encode('utf-8')
    else
      "\u265A".encode('utf-8')
    end
  end
end
