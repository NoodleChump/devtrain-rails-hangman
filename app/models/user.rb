class User < ActiveRecord::Base
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :games, :dependent => :destroy

  before_save { self.email = email.downcase }

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }, format: { with: EMAIL_REGEX }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def won_games
    games.select(&:won?)
  end

  def lost_games
    games.select(&:lost?)
  end

  def in_progress_games
    games.reject(&:game_over?)
  end

  def win_loss_rate
    if lost_games.count == 0
      won_games.count.to_f
    else
      won_games.count / lost_games.count.to_f
    end
  end
end
