require_relative 'piece'
require 'byebug'

class Pawn < Piece
  attr_accessor :first_move

  def initialize(player, position, board)
    @first_move = true
    super
  end

  def moves
    moves = []
    current_row, current_col = self.position
    if !self.first_move
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
    moves
  end



  def to_s
    if self.player == :white
      "\u2659".encode('utf-8')
    else
      "\u265F".encode('utf-8')
    end
  end

end
