class FindUserRanking
  def initialize(user)
    @user = user
  end

  def call
    users = User.order("rank_points DESC, name")
    users.index(@user) + 1
  end
end
