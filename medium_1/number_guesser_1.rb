class GuessingGame
  attr_reader :winning_number
  attr_accessor :guesses

  def initialize
    @guesses = 7
    @user_guess = nil
  end
  
  def reset
    @winning_number = rand(1..100)
    @guesses = 7
  end

  def decrease_guess_count
    self.guesses -= 1
  end

  def show_guess_count
    puts "You have #{guesses} guesses remaining."
  end

  def make_guess
    loop do
      puts "Enter a number between 1 and 100:"
      @user_guess = gets.chomp.to_i
      break if (1..100).include?(@user_guess)
      puts "Invalid guess."
    end
  end

  def check_guess
    if won?
      puts "That's the number!"
      winning_message
    elsif @user_guess < @winning_number
      puts "Your guess is too low."
    elsif @user_guess > @winning_number
      puts "Your guess is too high."
    end
  end

  def winning_message
    puts "You won!"
  end

  def losing_message
    puts "You have no more guesses. You lost!"
  end

  def won?
    @user_guess == @winning_number
  end

  def lost?
    if self.guesses == 0
      losing_message
      true
    end
  end

  def play
    reset
    loop do
      show_guess_count
      make_guess
      check_guess
      break if won?
      decrease_guess_count
      break if lost?
    end
  end
end

game = GuessingGame.new
game.play
