class MasterMindBreaker
  #later updates will be configured so the user is asked whether they would like to be code-maker or code-breaker
  def initialize
    @number_of_guesses = 3
    @game_won = false
    @color_code = generate_computer_code
    @guesses = []
    ask_for_guess(@color_code)
  end

  def generate_computer_code
    arr_of_colors = ["White", "Black", "Gray", "Yellow", "Red", "Blue", "Green", "Brown", "Pink", "Orange", "Purple"]
    arr_of_four_colors = []
    while arr_of_four_colors.length < 4
      arr_of_four_colors.push(arr_of_colors.sample.downcase)
    end
    return arr_of_four_colors
  end

  def ask_for_guess(code)
    puts "Input your guess below. \n There are four colors to be guessed, and you will be given hints throughout."
    while @number_of_guesses > 0
      p code
      puts "Enter guess in the following format: color, color, color, color."
      puts "Board: #{@guesses}"
      guess = gets.chomp
      compare_code = compare_code(guess)

      p compare_code
    end
    puts @game_won ? "You won!" : "You lost :("
  end

  def compare_code(guess)
    guess = guess.delete(",")
    guess_arr = guess.split(" ")
    hint_string = ""
    correct_guesses = []
    count = 0

    guess_arr.each.with_index do |element, index|
      if @color_code.at(index).include?(element)
        count += 1
        hint_string += "#{count}. #{element} is in the correct position at position #{index + 1}. \n"
        correct_guesses.insert(index, element) if @guesses.include?(element) == false
        @guesses.insert(index, element)
      elsif @color_code.at(index) != element && @color_code.include?(element)
        count += 1
        hint_string += "#{count}. #{element} is in the code but not at the right position \n"
        @guesses.insert(index, "--")
      else
        @guesses.insert(index, "--")
      end
    end
    puts hint_string

    if correct_guesses == @color_code
      @game_won = true
      @number_of_guesses = 0
      return @game_won
    elsif correct_guesses.length == 0
      @number_of_guesses -= 1
    else
      return correct_guesses
    end
  end

end

class MasterMindMaker
  def initialize
    @number_of_guesses = 3
    @game_won = false
    @color_code = ask_for_code
    display_computer_guess(@color_code)
  end

  def ask_for_code
    ask = true
    arr_of_colors = ["White", "Black", "Gray", "Yellow", "Red", "Blue", "Green", "Brown", "Pink", "Orange", "Purple"]
    arr_of_colors = arr_of_colors.map {|color| color.downcase}

    while ask
      puts "Please enter your secret code in the following format: color, color, color, color. Four colors only"
      puts "Available colors are: White, Black, Gray, Yellow, Red, Blue, Green, Brown, Pink, Orange, Purple"

      secret_code = gets.chomp
      secret_code = secret_code.delete(",")
      secret_code_arr = secret_code.split(" ")
      check_arr = secret_code_arr.all? {|color| arr_of_colors.include?(color)} && secret_code_arr.length == 1
      ask = false if check_arr == true
    end
    secret_code_arr
  end

  def generate_computer_guess
    arr_of_colors = ["White", "Black", "Gray", "Yellow", "Red", "Blue", "Green", "Brown", "Pink", "Orange", "Purple"]
    computer_guess = []

    while computer_guess.length < 1
      computer_guess.push(arr_of_colors.sample.downcase)
    end
    return computer_guess
  end

  def display_computer_guess(code)
    while @game_won == false
      puts "Is this your code? #{generate_computer_guess}"
      answer = gets.chomp.downcase

      if answer == "yes"
        puts "yes"
        @game_won = true
      else
        puts "no"
      end
    end
  end
end

end_loop = false

while end_loop == false
  puts "Would you like to be the code-breaker or code-maker? b for breaker, m for maker"
  answer = gets.chomp

  if answer == "b"
  end_loop = true
    puts new_game = MasterMindBreaker.new
  elsif answer == "m"
    end_loop = true
    puts new_game = MasterMindMaker.new
  else
    end_loop = false
  end
end
