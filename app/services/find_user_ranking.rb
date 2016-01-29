class FindUserRanking
  def initialize(user)
    @user = user
  end

  def call
    users = User.order("rank_points DESC, name") # This is called for each user and has horrible performance, even with a small amount of users
    users.index(@user) + 1
  end
end
