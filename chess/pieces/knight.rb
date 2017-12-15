require_relative 'piece'
require_relative 'stepping_module'

class Knight < Piece
  include SteppingPiece

  def initialize(player, position, board)
    super
  end

  def move_steps
    [[-2, 1], [-2, -1], [-1, 2], [-1, -2], [2,1], [2,-1], [1, 2], [1, -2]]
  end

  def to_s
    if self.player == :white
      " " + "\u2658".encode('utf-8') + " "
    else
      " " + "\u265E".encode('utf-8') + " "
    end
  end
end
