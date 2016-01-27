class GetSortedGames
  def initialize(sort_column, direction_order)
    @sort_column = sort_column
    @direction = direction_order
  end

  def call
    sorted_games
  end

  private

  def sorted_games
    case @sort_column
    when 'name'
      games_sorted_by_name
    when 'lives'
      games_sorted_by_lives
    when 'blanks'
      games_sorted_by_blanks
    when 'progress'
      games_sorted_by_progress
    when 'date'
      games_sorted_by_date
    when 'ranked'
      games_sorted_by_ranked
    else
      games_sorted_by_date
    end
  end

  def games_sorted_by_name
    Game.includes("user").order("users.name #{@direction}")
  end

  def games_sorted_by_lives
    games = Game.all.sort_by(&:number_of_lives_remaining)
    games.reverse! if @direction == "desc"
  end

  def games_sorted_by_blanks
    games = Game.all.sort_by { |game| (present game).number_of_blanks_remaining }
    games.reverse! if @direction == "desc"
    games
  end

  def games_sorted_by_progress
    games = Game.all.sort_by { |game| (present game).progression }
    games.reverse! if @direction == "desc"
    games
  end

  def games_sorted_by_date
    Game.order("created_at #{@direction}")
  end

  def games_sorted_by_ranked
    Game.order("custom #{@direction}")
  end
end
