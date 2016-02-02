class User < ActiveRecord::Base
  include Authentication
  
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :games, :dependent => :destroy

  before_save { self.email = email.downcase }

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 40 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }, format: { with: EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }

  attr_accessor :remember_token

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
    lost_ranked_games = lost_games.select(&:custom?)
    won_ranked_games = won_games.select(&:custom?)

    if lost_ranked_games.count == 0
      won_ranked_games.count.to_f
    else
      won_ranked_games.count / lost_ranked_games.count.to_f
    end
  end

  def update_rank_weight
    update_attribute(:rank_points, rank_weight)
  end

  private

  def rank_weight
    (win_loss_rate * games.reject(&:custom).length + won_games.reject(&:custom).count).to_i
  end
end
