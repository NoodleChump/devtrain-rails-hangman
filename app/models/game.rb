class Game < ActiveRecord::Base
  belongs_to :player
  has_many :guesses, :dependent => :destroy

  validates :word_to_guess, presence: true
  validates :number_of_lives, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :player, presence: true

  attr_accessor :custom_word

  def guessed_letters
    guesses.map(&:letter)
  end

  def censored_word
    if game_over?
      word_to_guess.chars
    else
      word_to_guess.chars.map do |letter|
        guessed_letters.include?(letter) ? letter : nil
      end
    end
  end

  def won?
    word_to_guess.chars.all? do |letter|
      guessed_letters.include?(letter.downcase)
    end
  end

  def out_of_lives?
    number_of_lives_remaining == 0
  end

  def lost?
    !won? && out_of_lives?
  end

  def game_over?
    won? || lost?
  end

  def incorrect_guesses
    guessed_letters - word_to_guess.chars
  end

  def progression #TODO Move this into presenter or as a field in DB
    if won?
      :won
    elsif lost?
      :lost
    elsif guesses.present?
      :in_progress
    else
      :not_started
    end
  end

  def number_of_lives_remaining
    [number_of_lives - incorrect_guesses.length, 0].max
  end
end
