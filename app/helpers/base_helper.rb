module BaseHelper
  def sort_link column, title = nil
    title ||= column.titleize
    column = column.downcase.parameterize.underscore
    dir = column == sort_col && sort_dir == "asc" ? "desc" : "asc"
    icon = sort_dir == "asc" ? "fa fa-chevron-up" : "fa fa-chevron-down"
    icon = column == sort_col ? icon : ""
    link_to "#{title} <span class='#{icon}'></span>".html_safe,
      sort: column, direction: dir
  end
end
