class Guess < ActiveRecord::Base
  belongs_to :hangman_state

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
      errors.add(:not_in_alphabet, "guessed letters must be in the English alphabet")
    end
  end

  def already_guessed?
    if hangman_state.guesses.any? { |guess| guess.letter == letter }
      errors.add(:already_guessed, "guessed letters must be unique")
    end
  end
end
