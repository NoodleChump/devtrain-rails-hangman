class Player < ActiveRecord::Base
  has_many :games, :dependent => :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }

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

  def ranking
    FindPlayerRanking.new.call({
        player: self
      })
  end
end
