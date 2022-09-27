# frozen_string_literal: true

# MasterMind class. Gets computer choice
class MasterMind
  attr_accessor :pc_chosen_colors, :guess, :user_chosen_colors

  def initialize
    @colors = %w[BLUE ORANGE PINK RED WHITE YELLOW]
    @pc_chosen_colors = []
    @aux_pc_chosen_colors = []
    @user_chosen_colors = []
    @aux_user_chosen_colors = []
    @guess = []
    @dic_color = { Color: '', Exists: false, Position: 'Incorrect' }
  end

  # Gets pc choices and assigns values to an auxiliar array for pc choices
  def pc_choices
    5.times do
      @pc_chosen_colors.push(@colors[rand(0..5)])
    end
    @pc_chosen_colors.each { |value| @aux_pc_chosen_colors.push(value) }
  end

  # Gets user choices and assigns values to an auxiliar array for user choices
  # User's array will be modify after each round is being called
  def user_choice
    n = 0
    while n < 5
      puts 'Choose a color. Options: BLUE, ORANGE, PINK, RED, WHITE, YELLOW'
      color = gets.chomp.upcase
      next unless @colors.include?(color)

      @user_chosen_colors.push(color)
      p @user_chosen_colors
      n += 1
    end
    @user_chosen_colors.each { |value| @aux_user_chosen_colors.push(value) }
  end

  def round
    check_values_in_equal_index(@aux_user_chosen_colors, @user_chosen_colors, @aux_pc_chosen_colors, @pc_chosen_colors)
    check_remainder_values_unequal_index(@user_chosen_colors, @pc_chosen_colors)

    @pc_chosen_colors = []
    @user_chosen_colors = []
    @aux_pc_chosen_colors.each { |value| @pc_chosen_colors.push(value) }
    @aux_user_chosen_colors.each { |value| @user_chosen_colors.push(value) }
  end

  # Check same index value from @pc_chosen_colors && @user_chosen_colors
  # If the values are equal, they are eliminated
  # Information is saved in @guess for feedback
  def check_values_in_equal_index(aux_guess_values, guess_values, aux_correct_values, correct_values)
    aux_guess_values.each_with_index do |color, i|
      next unless color == aux_correct_values[i]

      @dic_color[:Color] = color
      @dic_color[:Exists] = true
      @dic_color[:Position] = "#{i + 1} Correct"
      @guess.push(@dic_color)
      @dic_color = { Color: '', Exists: false, Position: 'Incorrect' }
      correct_values.delete_at(correct_values.find_index(color))
      guess_values.delete_at(guess_values.find_index(color))
    end
  end

  # Check remainder values from @pc_chosen_colors && @user_chosen_colors
  # It does not consider same index in this case
  # Information is saved in @guess for feedback
  def check_remainder_values_unequal_index(guess_values, correct_values)
    guess_values.each do |color|
      @dic_color[:Color] = color
      if correct_values.include?(color)
        @dic_color[:Exists] = true
        correct_values.delete_at(correct_values.find_index(color))
      end
      @guess.push(@dic_color)
      @dic_color = { Color: '', Exists: false, Position: 'Incorrect' }
    end
  end

  def game_user_mode
    pc_choices
    12.times do
      user_choice
      round
      @user_chosen_colors == @pc_chosen_colors ? break : print_round_results
    end
    puts @user_chosen_colors == @pc_chosen_colors ? 'You Win!' : 'You lost!'
  end

  def print_round_results
    puts
    print 'user: '
    p @user_chosen_colors
    puts
    print 'pc: '
    p @pc_chosen_colors
    # puts
    puts "Guess: \n\n#{@guess} \n\n Try again\n\n"
    @guess = []
    @user_chosen_colors = []
    @aux_user_chosen_colors = []
  end

  def select_mode
    while true
      puts 'Enter "user" to guess colors chosen by the computer'
      puts 'Enter "computer" to choose colors and make computer guess'
      mode = gets.chomp.upcase
      break if %w[USER COMPUTER].include?(mode)
    end
    mode == 'USER' ? game_user_mode : game_computer_mode
  end

  def game_computer_mode
    user_choice # This time this value is fixed
    12.times do
      pc_choices # This values changes a total of 12 times
      round_computer_mode
      @user_chosen_colors == @pc_chosen_colors ? break : print_round_results_computer
    end
    puts @user_chosen_colors == @pc_chosen_colors ? 'You lost!' : 'You Win!'
  end

  def print_round_results_computer
    puts
    print 'user: '
    p @user_chosen_colors
    puts
    print 'pc: '
    p @pc_chosen_colors
    # puts
    puts "Guess: \n\n#{@guess} \n\n Try again\n\n"
    @guess = []
    @pc_chosen_colors = []
    @aux_pc_chosen_colors = []
  end

  def round_computer_mode
    check_values_in_equal_index(@aux_pc_chosen_colors, @pc_chosen_colors, @aux_user_chosen_colors, @user_chosen_colors)
    check_remainder_values_unequal_index(@pc_chosen_colors, @user_chosen_colors)

    @pc_chosen_colors = []
    @user_chosen_colors = []
    @aux_pc_chosen_colors.each { |value| @pc_chosen_colors.push(value) }
    @aux_user_chosen_colors.each { |value| @user_chosen_colors.push(value) }
  end
end

matrix = MasterMind.new
matrix.select_mode
