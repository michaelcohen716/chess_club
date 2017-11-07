require_relative 'cursor'
require 'colorize'

class Display
  attr_reader :board, :cursor

  COLORS_HASH = {:color => :black, :background => :white}

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def test_display
    self.cursor.get_input
    self.render
  end

  def render
    system("clear")
    self.board.grid.each_with_index do |row, row_number|
      self.render_row(row, row_number)
      print "\n"
    end
  end

  def determine_colors(player, current_cursor_on, selected)
    hsh = {:color => :dark_blue}

    if current_cursor_on && selected
      hsh[:background] = :green
    elsif current_cursor_on
      hsh[:background] = :light_magenta
    end

    hsh
  end

  def render_row(row, row_number)
    print "|"
    row.each_with_index do |piece, col_number|
      current_cursor_on = self.cursor.cursor_pos == [row_number, col_number]

      color_hsh = determine_colors(piece.player, current_cursor_on, self.cursor.selected)

      print piece.to_s.colorize(color_hsh)
      print "|".colorize(:color => :dark_blue)
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  board = Board.standard_board
  display = Display.new(board)
  while true
    #system("clear")
    display.test_display
  end
end
