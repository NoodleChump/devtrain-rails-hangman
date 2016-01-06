class Guess < ActiveRecord::Base
  belongs_to :hangman_state

  validates :letter, presence: true, length: { is: 1 }
  validate :letter_in_alphabet?, :already_guessed?
  before_save :downcase_letter

  private

  def downcase_letter
     self.letter.downcase!
  end

  def letter_in_alphabet?
    if !('a'..'z').include?(letter.downcase)
      errors.add(:not_in_alphabet, "must be in the alphabet")
    end
  end

  def already_guessed?
    if hangman_state.guesses.any? { |guess| guess.letter == letter }
      errors.add(:already_guessed, "has already been guessed")
    end
  end
end
