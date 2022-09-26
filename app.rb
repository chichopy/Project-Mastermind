# frozen_string_literal: true

# MasterMind class. Gets computer choice
class MasterMind
  attr_accessor :pc_chosen_colors, :guess, :user_chosen_colors

  def initialize
    @colors = %w[BLUE ORANGE PINK RED WHITE YELLOW]
    @pc_chosen_colors = []
    @aux_pc_chosen_colors = []
    @user_chosen_colors = []
    @guess = []
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
  end

  def round
    @user_chosen_colors.each_with_index do |color, i|
      if @pc_chosen_colors.include?(color)
        comparison = @user_chosen_colors[i] == @aux_pc_chosen_colors[i]
        comparison ? @guess.push("Position & Color: #{color} Correct") : @guess.push("Only Color: #{color} Correct")
        @pc_chosen_colors.delete_at(@pc_chosen_colors.find_index(color))
      else
        @guess.push("Color: #{color} Incorrect")
      end
    end
    @pc_chosen_colors = @aux_pc_chosen_colors
  end
end

matrix = MasterMind.new
matrix.pc_choices
matrix.user_choice
matrix.round
# puts
# puts
# puts
# print 'user: '
# p matrix.user_chosen_colors
# puts
# print 'pc: '
# p matrix.pc_chosen_colors
# puts
# print 'guess: '
# p matrix.guess
