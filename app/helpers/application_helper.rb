module ApplicationHelper
  #REVIEW presenter_for
  def present(object, klass = nil)
    klass ||= "#{object.class.name}Presenter".constantize
    klass.new(object, self) # REVIEW nickj
=begin
def html
    @html ||= ActionView::Base.new.extend(ActionView::Helpers::TagHelper)
  end
=end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  private

  def sort_column #TODO ||
    params[:sort] ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
