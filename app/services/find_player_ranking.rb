class FindPlayerRanking #TODO Test me
  def initialize(player)
    @player = player
  end

  def call
    players = Player.all.sort_by { |player| rank_weight(player) }.reverse
    players.index(@player) + 1
  end

  private

  def rank_weight(player)
    player.win_loss_rate * player.games.length + player.won_games.count
  end
end
