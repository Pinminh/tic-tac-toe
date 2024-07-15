# Tic-tac-toe player object
class PlayerTTT
  attr_reader :mark_type

  def initialize(mark_type)
    raise 'invalid mark type' if mark_type != 'X' && mark_type != 'O'

    @mark_type = mark_type
    @score = 0
    @table = nil
  end

  def play_on(table)
    @table = table
  end

  def play(position)
    return false if @table.nil?

    @table.add_mark(position, @mark_type)
  end

  def win?
    marks = mark_type == 'X' ? @table.mark_x : @table.mark_o

    possible_win_marks = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
                          [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    result = false

    possible_win_marks.each do |win_marks|
      result ||= include_marks?(marks, win_marks)
    end

    result
  end

  private

  def include_marks?(marks, submarks)
    (marks & submarks).eql?(submarks)
  end
end
