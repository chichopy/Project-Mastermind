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
    check_values_in_equal_index
    check_remainder_values_unequal_index

    @pc_chosen_colors = []
    @user_chosen_colors = []
    @aux_pc_chosen_colors.each { |value| @pc_chosen_colors.push(value) }
    @aux_user_chosen_colors.each { |value| @user_chosen_colors.push(value) }
  end

  # Check same index value from @pc_chosen_colors && @user_chosen_colors
  # If the values are equal, they are eliminated
  # Information is saved in @guess for feedback
  def check_values_in_equal_index
    @aux_user_chosen_colors.each_with_index do |color, i|
      next unless color == @aux_pc_chosen_colors[i]

      @dic_color[:Color] = color
      @dic_color[:Exists] = true
      @dic_color[:Position] = "#{i + 1} Correct"
      @guess.push(@dic_color)
      @dic_color = { Color: '', Exists: false, Position: 'Incorrect' }
      @pc_chosen_colors.delete_at(@pc_chosen_colors.find_index(color))
      @user_chosen_colors.delete_at(@user_chosen_colors.find_index(color))
    end
  end

  # Check remainder values from @pc_chosen_colors && @user_chosen_colors
  # It does not consider same index in this case
  # Information is saved in @guess for feedback
  def check_remainder_values_unequal_index
    @user_chosen_colors.each do |color|
      @dic_color[:Color] = color
      if @pc_chosen_colors.include?(color)
        @dic_color[:Exists] = true
        @pc_chosen_colors.delete_at(@pc_chosen_colors.find_index(color))
      end
      @guess.push(@dic_color)
      @dic_color = { Color: '', Exists: false, Position: 'Incorrect' }
    end
  end

  def game
    pc_choices
    12.times do
      user_choice
      round
      @user_chosen_colors == @pc_chosen_colors ? break : print_round_results
    end
    puts @user_chosen_colors == @pc_chosen_colors ? 'You Win!' : 'You lost!'
  end

  def print_round_results
    # print 'user: '
    # p @user_chosen_colors
    # puts
    # print 'pc: '
    # p @pc_chosen_colors
    # puts
    puts "Guess: \n\n#{@guess} \n\n Try again\n\n"
    @guess = []
    @user_chosen_colors = []
    @aux_user_chosen_colors = []
  end
end

matrix = MasterMind.new
matrix.game
