module PlayersPresenter
  SORT_MAPPINGS = {
    'name' => -> (player) { player.name },
    'ranking' => -> (player) { player.ranking },
    'won' => -> (player) { player.won_games.length },
    'lost' => -> (player) { player.lost_games.length }
  }

  def apply_sort(games, field, direction)
    if sorter = SORT_MAPPINGS[field]
      games = games.sort_by(&sorter)
    else
      games = games.sort_by(&SORT_MAPPINGS['name'])
    end

    direction == "desc" ? games.reverse : games
  end
end
