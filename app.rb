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

  def pc_choices
    5.times do
      @pc_chosen_colors.push(@colors[rand(0..5)])
    end
    @pc_chosen_colors.each { |value| @aux_pc_chosen_colors.push(value) }
  end

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
    @user_chosen_colors.each_with_index do |color, i|
      next unless color == @pc_chosen_colors[i]

      @dic_color[:Color] = color
      @dic_color[:Exists] = true
      @dic_color[:Position] = "#{i + 1} Correct"
      @guess.push(@dic_color)
      @dic_color = { Color: '', Exists: false, Position: 'Incorrect' }
      @pc_chosen_colors.delete_at(@pc_chosen_colors.find_index(color))
      @user_chosen_colors.delete_at(@user_chosen_colors.find_index(color))
    end
    p 'Before enter user that iterates'
    p @user_chosen_colors
    @user_chosen_colors.each do |color|
      @dic_color[:Color] = color
      if @pc_chosen_colors.include?(color)
        @dic_color[:Exists] = true
        @guess.push(@dic_color)
        @dic_color = { Color: '', Exists: false, Position: 'Incorrect' }
        @pc_chosen_colors.delete_at(@pc_chosen_colors.find_index(color))
      else
        @guess.push(@dic_color)
        @dic_color = { Color: '', Exists: false, Position: 'Incorrect' }
      end
    end
    @pc_chosen_colors = []
    @user_chosen_colors = []
    @aux_pc_chosen_colors.each { |value| @pc_chosen_colors.push(value) }
    @aux_user_chosen_colors.each { |value| @user_chosen_colors.push(value) }
  end

  def game
    pc_choices
    user_win = false
    12.times do
      user_choice
      round
      if @user_chosen_colors == @pc_chosen_colors
        puts 'You Win!'
        user_win = true
        break
      else
        puts
        puts
        puts
        print 'user: '
        p @user_chosen_colors
        puts
        print 'pc: '
        p @pc_chosen_colors
        puts
        puts "Guess: \n\n#{@guess} \n\n Try again\n\n"
        @guess = []
        @user_chosen_colors = []
        @aux_user_chosen_colors = []
      end
    end
    puts 'You lost!' unless user_win
  end
end

matrix = MasterMind.new
matrix.game
