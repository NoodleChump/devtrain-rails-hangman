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

  def progress
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
    [number_of_lives - number_of_incorrect_guesses, 0].max
  end

  def number_of_blanks_remaining #refactor or shift out for view
    censored_word.count(nil)
  end

  def progress_percentage
    game_over? ? 100.0 : (number_of_incorrect_guesses / number_of_lives.to_f) * 100
  end

  private

  def number_of_incorrect_guesses
    (guessed_letters - word_to_guess.chars).length
  end
end
