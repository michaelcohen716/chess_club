require_relative 'piece'

class Pawn < Piece
  attr_accessor :num_moves

  def initialize(player, position, board)
    @num_moves = 0
    super
  end

  def moves
    moves = []
    current_row, current_col = self.position
    if self.num_moves > 0
      self.player == :white ? possible_moves = [[1,0]] : possible_moves = [[-1,0]]
    else
      self.player == :white ? possible_moves = [[1,0], [2,0]] : possible_moves = [[-2, 0],[-1,0]]
    end

    self.player == :white ? attacks = [[1,1],[1,-1]] : attacks = [[-1,1],[-1,-1]]

    possible_moves.each do |move|
      new_pos = [current_row + move[0], current_col + move[1]]
      other_piece = board[new_pos]
      moves << new_pos if self.board.in_board?(new_pos) && self.eval_other_piece(other_piece) == "Null"
    end

    attacks.each do |attack|
      new_pos = [current_row + attack[0], current_col + attack[1]]
      other_piece = board[new_pos]
      moves << new_pos if self.board.in_board?(new_pos) && self.eval_other_piece(other_piece) == "Other Player"
    end
    special_moves = []
    special_moves << en_passant if en_passant
    moves.concat(special_moves)
    moves.reject {|move| move == [nil]}
  end

  def en_passant
    current_row, current_col = self.position
    en_passant_attacks = [[0,1], [0,-1]]
    pawn_start = self.player == :white ? 4 : 3
    row_change = self.player == :white ? 1 : -1
    en_passant_move = nil

    if current_row == pawn_start
      en_passant_attacks.each do |attack|
        other_pos = [current_row, current_col + attack[1]]
        new_pos = [current_row + row_change, current_col+ attack[1]]
        other_piece = board[other_pos]
        if self.eval_other_piece(other_piece) == "Other Player" && other_piece.num_moves == 1
          if other_piece.class == Pawn && self.board.in_board?(new_pos)
            en_passant_move = [current_row + row_change, current_col + attack[1]]
          end
        end
      end
    end

    if en_passant_move.nil?
      nil
    else
      en_passant_move
    end
  end

  def to_s
    if self.player == :white
      "\u2659".encode('utf-8')
    else
      "\u265F".encode('utf-8')
    end
  end

end
