class Guess < ActiveRecord::Base
  ALPHABET = 'a'..'z'

  belongs_to :game

  before_validation :downcase_letter
  validates :letter, presence: true, length: { is: 1 }, inclusion: { in: ALPHABET }
  validate :not_already_guessed

  private

  def downcase_letter #TODO assign instead
    self.letter.downcase! # if letter
  end

  def not_already_guessed
    if game.guesses.pluck(:letter).include?(letter)
      errors.add(:letter, "has already been guessed")
    end
  end
end
