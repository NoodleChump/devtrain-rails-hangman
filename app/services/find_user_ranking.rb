class FindUserRanking
  def initialize(user)
    @user = user
  end

  def call
    users = User.all.sort_by { |user| rank_weight(user) }.reverse
    users.index(@user) + 1
  end

  private

  def rank_weight(user)
    user.win_loss_rate * user.games.length + user.won_games.count
  end
end
