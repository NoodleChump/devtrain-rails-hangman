module GamesPresenter
  SORT_MAPPINGS = {
    'name' => -> (game) { game.player.name },
    'guesses' => -> (game) { game.number_of_guesses_remaining },
    'blanks' => -> (game) { game.number_of_blanks_remaining },
    'progress' => -> (game) { game.progress }
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
