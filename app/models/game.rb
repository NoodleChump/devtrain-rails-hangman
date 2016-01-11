class Game < ActiveRecord::Base
  belongs_to :player
  has_many :guesses, :dependent => :destroy

  validates :word_to_guess, presence: true
  validates :number_of_lives, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :player, presence: true

  attr_accessor :custom_word #NOTE This is boolean kept for view on creation page

  CENSOR_CHARACTER = "*"

  def won?
    word_to_guess.chars.all? do |letter|
      guessed_letters.include? letter.downcase
    end
  end

  def lost?
    !won? && out_of_lives?
  end

  def game_over?
    won? || lost?
  end

  def guessed_letters
    guesses.map { |guess| guess.letter }
  end

  def number_of_guesses_remaining
    [number_of_lives - number_of_incorrect_guesses, 0].max
  end

  def progress
    if won?
      :won
    elsif lost?
      :lost
    elsif guesses.count == 0
      :not_started
    else
      :in_progress
    end
  end

  def censored_word
    return word_to_guess if game_over?
    word_to_guess.chars.map do |letter|
      (guessed_letters.include?(letter) ? letter : CENSOR_CHARACTER)
    end.join
  end

  def number_of_blanks_remaining
    censored_word.count(CENSOR_CHARACTER)
  end

  private

  def number_of_incorrect_guesses
    (guessed_letters - word_to_guess.chars).length
  end

  def out_of_lives?
    number_of_guesses_remaining == 0
  end
end
