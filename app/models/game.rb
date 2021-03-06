class Game < ActiveRecord::Base
  DEFAULT_NUMBER_OF_LIVES = 8

  belongs_to :user
  belongs_to :sender, foreign_key: "sender_id", class_name: "User"

  has_many :guesses, :dependent => :destroy

  validates :word_to_guess, presence: true
  validates :initial_number_of_lives, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :user, presence: true

  attr_accessor :custom_word

  def guessed_letters
    guesses.pluck(:letter)
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

  def number_of_lives_remaining
    [initial_number_of_lives - incorrect_guesses.length, 0].max
  end

  def ranked?
    !custom?
  end
end
