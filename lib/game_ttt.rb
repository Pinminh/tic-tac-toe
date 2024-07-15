require_relative 'table_ttt'
require_relative 'player_ttt'

# Tic-tac-toe game object
class GameTTT
  def initialize
    @table = TableTTT.new
    @player_x = PlayerTTT.new('X')
    @player_o = PlayerTTT.new('O')
    @current_player = @player_x
    @x_win = false
    @o_win = false

    @player_x.play_on(@table)
    @player_o.play_on(@table)
  end

  def ask_who_go_first
    print ' <?> Who will go first? (X or O): '
    $stdout.flush
    self.go_first_player = gets.chomp.strip.upcase
  rescue RuntimeError
    puts ' <!> Can only choose X or O. Please try again!'.colorize(:red)
    retry
  else
    puts " </> #{@current_player.mark_type}-player will go first.".colorize(:green)
  end

  def play_round
    @table.print
    ask_for_movement

    @x_win = @player_x.win?
    @o_win = @player_o.win?

    @player_x.add_score if @x_win
    @player_o.add_score if @o_win

    @current_player = @current_player.mark_type == 'X' ? @player_o : @player_x
  end

  def conclude_game
    @table.print

    return puts ' </> The match is draw!'.colorize(:yellow) unless @x_win || @o_win

    puts " </> #{@x_win ? 'X' : 'O'}-player has won! Congratulations!".colorize(:yellow)
  end

  def start
    clear_terminal
    puts 'Start Tic-tac-toe game...'.colorize(:green)
    ask_who_go_first

    9.times do
      clear_terminal
      play_round
      break if @x_win || @o_win
    end

    clear_terminal
    conclude_game
  end

  private

  def go_first_player=(mark_type)
    raise 'invalid mark type' if mark_type != 'X' && mark_type != 'O'

    @current_player = mark_type == 'X' ? @player_x : @player_o
  end

  def ask_for_movement
    print " <?> Enter position for #{@current_player.mark_type}: "
    position = gets.chomp.to_i

    @current_player.play(position)
  rescue RuntimeError => e
    if e.to_s == 'invalid position'
      puts ' <!> Can only choose from 1 to 9. Please try again!'.colorize(:red)
    else
      puts ' <!> Chosen position is occupied. Please try again!'.colorize(:red)
    end
    retry
  end

  def clear_terminal
    system('clear') || system('cls')
  end
end
