class UsersPresenter < BasePresenter
  SORT_MAPPINGS = {
    'name' => -> (user) { user.name },
    'ranking' => -> (user) { FindUserRanking.new(user).call() },
    'won' => -> (user) { user.won_games.length },
    'lost' => -> (user) { user.lost_games.length },
    'date' => -> (game) { game.created_at }
  }

  def self.apply_sort(users, field, direction)
    if sorter = SORT_MAPPINGS[field]
      users = users.sort_by(&sorter)
    else
      users = users.sort_by(&SORT_MAPPINGS['name'])
    end

    direction == "desc" ? users.reverse : users
  end
end
