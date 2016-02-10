class CompletedGameNotification < Notification
  belongs_to :game, foreign_key: "game_id"

  def description
    "#{sender.name} #{win_status} your game!"
  end

  def read_action
    game
  end

  private

  def win_status
    game.won? ? "won" : "lost"
  end
end
