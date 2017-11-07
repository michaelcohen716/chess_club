require_relative "pieces/piece"
require_relative "pieces/rook"
require_relative "pieces/bishop"
require_relative "pieces/queen"
require_relative "pieces/king"
require_relative "pieces/knight"
require_relative "pieces/pawn"
require_relative "exceptions"
require_relative "display"

class Board

  attr_accessor :grid

  def initialize(grid=[])
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
          player = :white
          self.populate_back_row(player, row)
        elsif row == 1
          player = :white
          self[pos] = Pawn.new(player, pos, self)
        elsif row == 6
          player = :black
          self[pos] = Pawn.new(player, pos, self)
        elsif row == 7
          player = :black
          self.populate_back_row(player, row)
        else
          self[pos] = NullPiece.instance
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
      self[pos] = Queen.new(player, pos, self) if col == 4
      self[pos] = King.new(player, pos, self) if col == 3
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
    #debugger
    raise NoPieceError.new("There is no piece at the start position") if self[start_pos].class == NullPiece
    raise NonExistentPosError.new("End Position doesn't exist") if self[end_pos].nil?
    raise NonValidMoveError.new("Not valid move for this piece") if !self[start_pos].valid_moves.include?(end_pos)

    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.instance
    self[end_pos].first_move = false if self[end_pos].class == Pawn
    self[end_pos].position = end_pos
  end

  def move_piece!(start_pos, end_pos)
    raise NoPieceError.new("There is no piece at the start position") if self[start_pos].class == NullPiece
    raise NonExistentPosError.new("End Position doesn't exist") if self[end_pos].nil?

    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.instance
    self[end_pos].first_move = false if self[end_pos].class == Pawn
    self[end_pos].position = end_pos
  end

  def in_check?(player)
    king = self.grid.flatten.find {|piece| piece.class == King && player == piece.player}
    king_position = king.position
    other_player_pieces = self.grid.flatten.select {|piece| piece.player != player && piece.class != NullPiece}

    other_player_pieces.each do |piece|
      return true if piece.moves.include?(king_position)
    end
    false
  end

  def checkmate?(player)
    my_pieces = self.grid.flatten.select {|piece| piece.player == player }
    #debugger
    my_pieces.each do |piece|
      return false if !piece.valid_moves.empty?
    end
    true
  end

  def dup_board
    dup_board = Board.new

    self.grid.each do |row|
      row_add = []
      row.each do |piece|
        if piece.class == NullPiece
          row_add << NullPiece.instance
        else
          row_add << piece.class.new(piece.player, piece.position, dup_board)
        end
      end
      dup_board.grid << row_add
    end
    dup_board
  end
end
