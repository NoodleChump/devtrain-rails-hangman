module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

#TODO put into presenter
  def apply_sort(items, sort_functions, sort_direction)
    items = items.sort_by { |item| sort_functions.split(".")
      .reduce(item) { |item, sort_function| item.send(sort_function) }}
    sort_direction == "desc" ? items.reverse : items
  end

  def apply_sort(games, field)
    case field
    when 'name' then games.sort_by { |game| game.player.name }
    else games
    end
  end

  SORT_MAPPINGS = {
    'name' => -> (game) { game.player.name }
  }

  def apply_sort(games, field)
    if sorter = SORT_MAPPINGS[field]
      games.sort_by(&sorter)
    else
      games
    end
  end

  private

  def sort_column
    params[:sort] ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
