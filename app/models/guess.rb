class Guess < ActiveRecord::Base
  ALPHABET = 'a'..'z'

  belongs_to :game

  before_validation :downcase_letter
  validates :letter, presence: true, length: { is: 1 }, inclusion: { in: ALPHABET }

  after_save :update_user_rank

  private

  def downcase_letter
    letter = letter.downcase if letter
  end

  def user
    game.user
  end

  def update_user_rank
    if game.game_over?
      user.update_rank_weight
    end
  end
end
