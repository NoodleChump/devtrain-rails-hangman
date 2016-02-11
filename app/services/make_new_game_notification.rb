class MakeNewGameNotification
  def initialize(from: nil, to: nil, game: nil)
    @sender = from
    @receiver = to
    @game = game
  end

  def call
    NewGameNotification.create!(
      sender: @sender,
      receiver: @receiver,
      game_id: @game.id
    )
  end
end
