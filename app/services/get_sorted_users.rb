class GetSortedUsers
  def initialize(sort_column, direction_order)
    @sort_column = sort_column
    @direction = direction_order
  end

  def call
    sorted_users
  end

  private

  def sorted_users
    case @sort_column
    when 'name'
      users_sorted_by_name
    when 'ranking'
      users_sorted_by_ranking
    when 'won'
      users_sorted_by_won
    when 'lost'
      users_sorted_by_lost
    when 'date'
      users_sorted_by_date
    else
      users_sorted_by_name
    end
  end

  def users_sorted_by_name
    User.order("name #{@direction}")
  end

  def users_sorted_by_ranking
    User.order("rank_points #{@direction}, name #{reversed_direction}")
  end

  def users_sorted_by_won
    users = User.all.sort_by { |game| game.won_games.length }
    users.reverse! if @direction == "desc"
    users
  end

  def users_sorted_by_lost
    users = User.all.sort_by { |game| game.lost_games.length }
    users.reverse! if @direction == "desc"
    users
  end

  def users_sorted_by_date
    User.order("created_at #{@direction}")
  end

  def reversed_direction
    @direction == "asc" ? "desc" : "asc"
  end
end
