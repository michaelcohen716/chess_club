module SlidingPiece

  def get_moves_one_direction(possible_positions)
    moves = []
    possible_positions.each do |pos|
      other_piece = self.board[pos]
      compare = self.eval_other_piece(other_piece)
      if compare == "Null"
        moves << pos
      elsif compare == "Same Player"
        break
      else
        moves << pos
        break
      end
    end
    moves
  end

  def moves
    all_moves = []
    directions = self.move_dirs
    directions.each do |dir|
      possible = self.get_possible_positions(dir,self.position)
      one_dir_moves = get_moves_one_direction(possible)
      all_moves.concat(one_dir_moves)
    end
    all_moves
  end

  def get_possible_positions(direction, pos)
    current_row, current_col = pos
    vert_dir, hor_dir = direction
    potential_positions = []

    new_pos = [current_row + vert_dir, current_col + hor_dir]
    until !self.board.in_board?(new_pos)
      potential_positions << new_pos
      new_pos = [new_pos[0] + vert_dir, new_pos[1] + hor_dir]
    end
    potential_positions
  end

end
