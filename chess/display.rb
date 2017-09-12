#require_relative 'board'
require_relative 'cursor'
require 'colorize'

class Display
  attr_reader :board, :cursor

  COLOR_HASH = {:color => :black, :background => :white}
  #CURSOR_COLOR_HASH = {:color => :white, :background => :black}

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
    #self
  end

  def determine_colors(player, current_cursor_on, selected)
    hsh = {}

    if player == :white
      hsh[:color] = :dark_blue
    else
      hsh[:color] = :red
    end

    if current_cursor_on && selected
      hsh[:background] = :green
    elsif current_cursor_on
      hsh[:background] = :light_magenta
    else
      hsh[:background] = :white
    end
    hsh
  end

  def render_row(row, row_number)
    print "|"
    row.each_with_index do |piece, col_number|
      current_cursor_on = self.cursor.cursor_pos == [row_number, col_number]
      #debugger
      color_hsh = determine_colors(piece.player, current_cursor_on, self.cursor.selected)

      # if self.cursor.cursor_pos == [row_number, col_number]
      #   hsh = CURSOR_COLOR_HASH
      # else
      #   hsh = COLOR_HASH
      # end
      print piece.to_s.colorize(color_hsh)
      print "|".colorize(:color => :dark_blue, :background => :white)
    end
  end

end
