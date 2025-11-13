# Tic-Tac-Toe

This tic-tac-toe implementation is an excellent learning project that demonstrates several fundamental programming concepts and Ruby best practices.

## What I Learn From This Project


### 1. Object-Oriented Programming (OOP)

**Class Design & Separation of Concerns**
- **GameTTT**: Orchestrates the game flow, managing turns and game state
- **PlayerTTT**: Encapsulates player behavior, moves, and win detection
- **TableTTT**: Handles board state and display logic

This demonstrates the Single Responsibility Principle - each class has one clear purpose.

**Encapsulation**
- Private methods (`go_first_player=`, `ask_for_movement`, `clear_terminal`) hide implementation details
- Attribute readers control access to internal state (`attr_reader :mark_type, :score`)
- The `mark_x` and `mark_o` methods return cloned arrays to prevent external modification

**Object Collaboration**
- Players are connected to the table via `play_on(table)`
- Objects communicate through well-defined interfaces

### 2. Error Handling & User Input Validation

**Exception Handling with Retry**
```ruby
rescue RuntimeError
  puts ' <!> Can only choose X or O. Please try again!'.colorize(:red)
  retry
```
- Custom error messages for different failure scenarios
- Using `retry` to allow users to correct their input
- Distinguishing between different error types (`'invalid position'` vs `'occupied position'`)

**Input Validation**
- Range checking (`position < 1 || position > 9`)
- State validation (`@table.occupied?(position)`)
- Type validation (`mark_type != 'X' && mark_type != 'O'`)

### 3. Game Logic & Algorithms

**Win Detection Algorithm**
```ruby
possible_win_marks = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
                      [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
```
- Defines all winning combinations
- Uses array intersection to check if a player has a winning pattern
- The `include_marks?` method cleverly uses `(marks & submarks).eql?(submarks)` to check if all required positions are marked

**Game State Management**
- Tracking player turns
- Score persistence across rounds
- Draw detection (when 9 turns pass without a winner)

### 4. Ruby Language Features

**String Manipulation**
- `gets.chomp.strip.upcase` - chaining methods for input sanitization
- String interpolation: `"#{@current_player.mark_type}"`

**Collections & Iteration**
- Using arrays to store marks: `@mark_x.push(position).sort!`
- `each_with_index` for board rendering
- Array operations: `&` (intersection), `map(&:clone)`

**Method Chaining**
- `@mark_x.push(position).sort!` - modifies and returns sorted array

### 5. User Interface Design

**Colorized Output**
- Using the `colorize` gem for better visual feedback
- Different colors for different game elements (X is red, O is blue, positions are gray)
- Color-coded messages (errors in red, success in green, info in yellow)

**Console Clearing**
- Cross-platform terminal clearing: `system('clear') || system('cls')`
- Keeps the interface clean between turns

**Board Visualization**
```
	| 1 | 2 | 3 |
	| 4 | 5 | 6 |
	| 7 | 8 | 9 |
```
- Dynamic board rendering that updates with player marks
- Clear position numbering for user input

### 6. Code Organization & Project Structure

**File Organization**
```
lib/
  game_ttt.rb    # Main game controller
  player_ttt.rb  # Player logic
  table_ttt.rb   # Board logic
tic_tac_toe.rb   # Entry point
```

**Dependency Management**
- Gemfile for managing external dependencies
- RuboCop for code quality and consistency
- Proper `require_relative` usage

### 7. Best Practices

**Naming Conventions**
- Clear, descriptive method names: `ask_who_go_first`, `conclude_game`
- Boolean methods end with `?`: `win?`, `occupied?`
- Setter methods use `=`: `go_first_player=`

**Code Readability**
- Consistent indentation and formatting
- Logical grouping of methods (public vs private)
- Guard clauses for early returns

**Defensive Programming**
- Nil checks: `raise 'no table attached to player' if @table.nil?`
- Type validation throughout
- State verification before operations

### 8. Testing Concepts (Implicit)

While there are no explicit tests, the code structure makes it testable:
- Methods are small and focused
- Dependencies are injected (player receives table via `play_on`)
- Game logic is separated from I/O
- Pure functions like `include_marks?` are easy to test

### 9. Game Design Patterns

**State Management**
- Game states: setup, playing, game over
- Turn management with player switching
- Score tracking across multiple games

**Game Loop**
```ruby
9.times do
  play_round
  break if @x_win || @o_win
end
```
- Fixed maximum iterations with early exit condition

### Key Takeaways

1. **OOP Design**: How to break down a problem into cohesive, loosely-coupled classes
2. **Error Recovery**: Using exceptions and retry for robust user input handling
3. **Algorithm Design**: Implementing win detection efficiently
4. **User Experience**: Making a console application user-friendly with colors and clear messages
5. **Code Quality**: Writing clean, maintainable Ruby code following conventions
6. **Project Organization**: Structuring a small Ruby project properly

This project is perfect for learning because it's:
- Small enough to understand completely
- Complex enough to demonstrate real concepts
- Practical and interactive
- Well-structured and following best practices

---
