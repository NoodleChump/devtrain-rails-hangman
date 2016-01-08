class Player < ActiveRecord::Base
  has_many :hangman_states, :dependent => :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }

  def games
    hangman_states
  end

  def won_games
    hangman_states.select { |game| game.won? }
  end

  def lost_games
    hangman_states.select { |game| game.lost? }
  end
end
