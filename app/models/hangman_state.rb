class HangmanState < ActiveRecord::Base
  belongs_to :player
  has_many :guesses, :dependent => :destroy

  validates :word_to_guess, presence: true
  validates :number_of_lives, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

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

  private

  def number_of_incorrect_guesses
    (guessed_letters - word_to_guess.chars).length
  end

  def out_of_lives?
    number_of_guesses_remaining == 0
  end
end
