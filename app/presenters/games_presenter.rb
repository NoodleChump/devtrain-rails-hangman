include ApplicationHelper

class GamesPresenter < BasePresenter
  SORT_MAPPINGS = {
    'name' => -> (game) { game.player.name },
    'guesses' => -> (game) { game.number_of_lives_remaining },
    'blanks' => -> (game) { (present game).number_of_blanks_remaining },
    'progress' => -> (game) { (present game).progression },
    'date' => -> (game) { game.created_at }
  }

  def self.apply_sort(games, field, direction)
    sorter = choose_sorter(field)
    games = games.sort_by(&sorter)
    direction == "desc" ? games.reverse : games
  end

  def self.choose_sorter(field)
    if sorter = SORT_MAPPINGS[field]
      sorter
    else
      SORT_MAPPINGS['name']
    end
  end
end
