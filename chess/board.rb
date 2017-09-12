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
          player = "player1"
          self.populate_back_row(player, row)
        elsif row == 1
          player = "player1"
          self[pos] = Pawn.new(player, pos, self)
        elsif row == 6
          player = "player2"
          self[pos] = Pawn.new(player, pos, self)
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
    debugger
    raise NoPieceError.new("There is no piece at the start position") if self[start_pos].class == NullPiece
    raise NonExistentPosError.new("End Position doesn't exist") if self[end_pos].nil?
    raise NonValidMoveError if !self[start_pos].valid_moves.include?(end_pos)

    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new
    self[end_pos].first_move = false if self[end_pos].class == Pawn
    self[end_pos].position = end_pos
  end

  def move_piece!(start_pos, end_pos)
    raise NoPieceError.new("There is no piece at the start position") if self[start_pos].class == NullPiece
    raise NonExistentPosError.new("End Position doesn't exist") if self[end_pos].nil?

    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new
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
          row_add << NullPiece.new
        else
          row_add << piece.class.new(piece.player, piece.position, dup_board)
        end
      end
      dup_board.grid << row_add
    end
    dup_board
  end
end


# if __FILE__ == $PROGRAM_NAME
#   board = Board.standard_board
#   board.move_piece([0,2],[5,2]) #move defending bishop elsewhere
#   board.move_piece([1,3],[0,2]) #move pawn from in front of king
#
#   board.move_piece([1,2],[0,2]) #move pawn from in front of king
#   board.move_piece([7,0],[3,3]) #move attacking rook to check of king
#   board.move_piece([0,4],[2,7]) #move defending queen to where she is obstructed by own pawn
#   board.move_piece([7,2],[3,0]) #move attacking bishop to double-check
#   board.move_piece([1,7],[0,4]) #move defense pawn to obstruct king
#
#   board.move_piece([0,1],[2,0]) #move defending knight elsewhere
#   puts board.in_check?("player1")
#   puts board.checkmate?("player1")
#   display = Display.new(board)
#   display.render
# end
#   puts board.in_check?("player1")
#   # pawn2 = Pawn.new("player2", [5,4], board)
#   # pawn3 = Pawn.new("player2", [5,3], board)
#   # board[[5,4]] = pawn2
#   # board[[5,3]] = pawn3
#   #
#   # pawn1 = Pawn.new("player1", [4,4], board)
#   #
#   # x= pawn1.moves
#   # puts x
#   # # #board[[4,1]] = Rook.new("player1", [4,1], board)
#   # # x = rook1.moves(true, false)
#   # # puts x
#   #
#   # knight = Knight.new("player1", [2,2], board)
#   # s = knight.moves
#   # puts s
#
# end
