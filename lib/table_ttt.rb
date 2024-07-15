require 'colorize'

# Tic-tac-toe table object
class TableTTT
  def initialize
    @table = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @mark_x = []
    @mark_o = []
  end

  def add_mark(position, mark_type)
    raise 'invalid mark type' if mark_type != 'X' && mark_type != 'O'
    return false if position < 1 || position > 9

    @table[position - 1] = mark_type
    @mark_x.push(position).sort! if mark_type == 'X'
    @mark_o.push(position).sort! if mark_type == 'O'

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

  def mark_x
    @mark_x.map(&:clone)
  end

  def mark_o
    @mark_o.map(&:clone)
  end

  private

  def colorize_mark(mark)
    cmark = nil
    cmark = mark.to_s.colorize(:gray) if mark.is_a?(Integer)
    cmark = mark.colorize(:red) if mark == 'X'
    cmark = mark.colorize(:blue) if mark == 'O'
    cmark
  end
end
