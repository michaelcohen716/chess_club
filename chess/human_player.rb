require_relative "exceptions"

class HumanPlayer

  attr_reader :color
  def initialize(name, color)
    @name = name
    @color = color
  end

  def check_piece_is_mine(start_pos, board)
    raise NotYourPieceError.new("Can't move other player's piece") if board[start_pos].player != self.color
  end

  def to_s
    self.color.to_s
  end


  def play_turn(display, board)
    begin
      display.render
      puts "#{self.to_s}'s turn!"
      sleep(0.5)
      start_pos = nil
      end_pos = nil

      until !start_pos.nil? && !end_pos.nil?
        cursor_return = display.cursor.get_input
        display.render

        if cursor_return.class == Array && display.cursor.selected
          start_pos = cursor_return
        elsif cursor_return.class == Array && !display.cursor.selected
          end_pos = cursor_return
        end

      end

      self.check_piece_is_mine(start_pos, board)
      board.move_piece(start_pos, end_pos)

      rescue NoPieceError => npe
        puts npe.message
        sleep(1)
        retry

      rescue NonExistentPosError => nepe
        puts nepe.message
        sleep(1)
        retry

      rescue NonValidMoveError => nvme
        puts nvme.message
        sleep(1)
        retry

      rescue NotYourPieceError => nype
        puts nype.message
        sleep(1)
        retry
    end

  end
end
