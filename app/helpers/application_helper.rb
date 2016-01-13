module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end


  # TODO - burn the eval - sort_function = "id; File.readlines('/etc/password').map({|thing| puts thing})"
  # ['player', 'id'].reduce(game) { |receiver, method| receiver.send(method) }
  # NOTE Is this helper or presenter logic?
  def apply_sort(items, sort_function, sort_direction)
    items = items.sort_by { |item| eval("item." + sort_function) }
    sort_direction == "desc" ? items.reverse : items
  end

  private

  def sort_column
    params[:sort] ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
