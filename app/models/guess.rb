class Guess < ActiveRecord::Base
  belongs_to :game

  validates :letter, presence: true, length: { is: 1 }
  validate :letter_in_alphabet?, :already_guessed?
  before_save :downcase_letter

  ALPHABET = 'a'..'z'

  private

  def downcase_letter
     self.letter.downcase!
  end

  def letter_in_alphabet?
    if !(ALPHABET).include?(letter.downcase)
      errors.add(:letter, "must be in the English alphabet")
    end
  end

  def already_guessed?
    if game.guesses.any? { |guess| guess.letter == letter }
      errors.add(:letter, "has already been guessed")
    end
  end
end
