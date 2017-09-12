require_relative "pieces/piece"
require_relative "pieces/rook"
require_relative "exceptions"

class Board

  attr_accessor :grid

  def initialize(grid)
    @grid = grid
    self.populate_grid
  end

  def self.standard_board
    grid = Array.new(8) {Array.new(8)}
    Board.new(grid)
  end

  def num_rows
    self.grid.length
  end

  def num_cols
    self.grid[0].length
  end

  def populate_grid
    (0...num_rows).each do |row|
      (0...num_cols).each do |col|
        pos = [row, col]
        if row < 2
          self[pos] = Piece.new("player1", pos, self)
        elsif row > 5
          self[pos] = Piece.new("player2", pos, self)
        else
          self[pos] = NullPiece.new
        end
      end
    end
  end

  def [](pos)
    row, col  = pos
    return nil if row < 0 || row > 7 || col < 0 || col > 7
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    self.grid[row][col] = value
  end

  def inspect
    "This is a board"
  end

  def in_board?(pos)
    !self[pos].nil?
  end

  def move_piece(start_pos, end_pos)
    raise NoPieceError.new("There is no piece at the start position") if self[start_pos].class == NullPiece
    raise NonExistentPosError.new("End Position doesn't exist") if self[end_pos].nil?

    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new

  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.standard_board
  # rook1 = Rook.new("player1", [4,4], board)
  # #board[[4,1]] = Rook.new("player1", [4,1], board)
  # x = rook1.moves(true, false)
  # puts x

  rook1 = Rook.new("player1", [4,4], board)
  s = rook1.moves
  puts s

end
