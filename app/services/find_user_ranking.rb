class FindUserRanking
  def initialize(user)
    @user = user
  end

  def call
    @user.rank_points #TODO As below is much too slow, just use and display the rank POINTS/SCORE, display as this on the view too
    #users = User.order("rank_points DESC, name") # This is called for each user and has horrible performance, even with a small amount of users
    #users.index(@user) + 1
  end
end
