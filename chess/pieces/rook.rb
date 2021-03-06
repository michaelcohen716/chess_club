require_relative 'piece'
require_relative 'sliding_module'

class Rook < Piece
  include SlidingPiece

  def initialize(player, position, board)
    super
  end

  def move_dirs
    return [[0,1],[0,-1], [1,0], [-1,0]]
  end

  def to_s
    if self.player == :white
       " " + "\u2656".encode('utf-8') + " "
    else
       " " + "\u265C".encode('utf-8') + " "
    end
  end
end
