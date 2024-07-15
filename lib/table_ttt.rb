require 'colorize'

# Tic-tac-toe table object
class TableTTT
  def initialize
    @table = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @mark_x = []
    @mark_o = []
  end

  def add_mark(position, mark_type)
    raise 'invalid mark type' if mark_type != 'X' || mark_type != 'O'

    index = (position - 1) % @table.length
    return false if @table[index] == 'X' || @table[index] == 'O'

    @table[index] = mark_type
    @mark_x.push(mark_type) if mark_type == 'X'
    @mark_o.push(mark_type) if mark_type == 'O'

    true
  end

  def print
    line = ''

    @table.each_with_index do |mark, index|
      return false if (cmark = colorize_mark(mark)).nil?

      line += " #{cmark} |"
      line.prepend('|') if (index % 3).zero?
      puts line if index % 3 == 2
      line = '' if index % 3 == 2
    end

    true
  end

  def colorize_mark(mark)
    cmark = nil
    cmark = mark.to_s.colorize(:gray) if mark.is_a?(Integer)
    cmark = mark.colorize(:red) if mark == 'X'
    cmark = mark.colorize(:blue) if mark == 'O'
    cmark
  end
end
