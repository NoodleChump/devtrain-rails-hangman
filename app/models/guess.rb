class Guess < ActiveRecord::Base
  ALPHABET = 'a'..'z'

  belongs_to :game

  before_validation :downcase_letter
  validates :letter, presence: true, length: { is: 1 }, inclusion: { in: ALPHABET }

  private

  def downcase_letter
    letter = letter.downcase if letter
  end
end
