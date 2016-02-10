class NewGameNotification < Notification
  belongs_to :game, foreign_key: "game_id"

  def description
    "#{sender.name} sent you a new game!"
  end

  def read_action
    game
  end
end
