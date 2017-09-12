module SteppingPiece

  def moves
    moves = []
    current_row, current_col = self.position

    possible_moves = self.move_steps.map {|mv| new_pos = [current_row + mv[0], current_col + mv[1]]}
    possible_moves.select! {|pos| self.board.in_board?(pos)}

    possible_moves.each do |pos|
      other_piece = self.board[pos]
      compare = self.eval_other_piece(other_piece)
      moves << pos if compare == "Null" || compare == "Other Player"
    end
    moves
  end




end
