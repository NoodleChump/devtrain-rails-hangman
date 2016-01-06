class Guess < ActiveRecord::Base
  belongs_to :hangman_state

  validates :letter, presence: true, length: { is: 1 }
  validate :letter_in_alphabet?

  private

  def letter_in_alphabet?
    if !('a'..'z').include?(letter)
      errors.add(:letter, "must be in the alphabet")
    end
  end

  def unique_guess?
    
  end
end
