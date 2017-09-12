require_relative "pieces/piece"
require_relative "pieces/rook"
require_relative "pieces/bishop"
require_relative "pieces/queen"
require_relative "exceptions"
require_relative "pieces/king"
require_relative "pieces/knight"


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
        if row == 0
          player = "player1"
          self.populate_back_row(player, row)
        elsif row == 1
          player = "player1"
          self[pos] = Piece.new(player, pos, self)
        elsif row == 6
          player = "player2"
          self[pos] = Piece.new(player, pos, self)
        elsif row == 7
          player = "player2"
          self.populate_back_row(player, row)
        else
          self[pos] = NullPiece.new
        end
      end
    end
  end

  def populate_back_row(player, row)
    (0..7).each do |col|

      pos = [row, col]
      self[pos] = Rook.new(player, pos, self) if col == 0 || col == 7
      self[pos] = Knight.new(player, pos, self) if col == 1 || col == 6
      self[pos] = Bishop.new(player, pos, self) if col == 2 || col == 5
      # self[pos] = Queen.new(player, pos, self) if col == 3
      # self[pos] = King.new(player, pos, self) if col == 4
    end
    row == 0 ? self[[row,3]] = King.new(player,[row,3], self) : self[[row,3]] = Queen.new(player,[row,3], self)
    row == 0 ? self[[row,4]] = Queen.new(player,[row,4], self) : self[[row,4]] = King.new(player,[row,4], self)
    row == 7 ? self[[row,3]] = Queen.new(player,[row,3], self) : self[[row,3]] = King.new(player,[row,3], self)
    row == 7 ? self[[row,4]] = King.new(player,[row,4], self) : self[[row,4]] = Queen.new(player,[row,4], self)
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

# if __FILE__ == $PROGRAM_NAME
#   # board = Board.standard_board
#   # # rook1 = Rook.new("player1", [4,4], board)
#   # # #board[[4,1]] = Rook.new("player1", [4,1], board)
#   # # x = rook1.moves(true, false)
#   # # puts x
#   #
#   # knight = Knight.new("player1", [2,2], board)
#   # s = knight.moves
#   # puts s
#
# end
