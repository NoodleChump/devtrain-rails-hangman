module GamesPresenter
  SORT_MAPPINGS = {
    'name' => -> (game) { game.player.name },
    'guesses' => -> (game) { game.number_of_lives_remaining },
    'blanks' => -> (game) { game.number_of_blanks_remaining },
    'progress' => -> (game) { game.progression }
  }

  def apply_sort(games, field, direction)
    if sorter = SORT_MAPPINGS[field]
      games = games.sort_by(&sorter)
    else
      games = games.sort_by(&SORT_MAPPINGS['name'])
    end

    direction == "desc" ? games.reverse : games
  end

  class GamePresenter
    CENSOR_CHARACTER = "*"

    delegate :player, to: :@game

    def initialize(game)
      @game = game
    end

    def _h
      @game
    end

    def method_missing(m, *args, &block)
      @game.send(m, *args, &block)
    end

    def censored_word
      @game.censored_word.map { |item| item != nil ? item : CENSOR_CHARACTER }.join
    end
  end
end
