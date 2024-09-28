module ApplicationHelper
  def bootstrap_paginate(current_page, total_pages)
    content_tag :ul, class: 'pagination justify-content-center' do
      # Previous Page Link
      concat(content_tag(:li, class: "page-item #{'disabled' if current_page == 1}") do
        link_to 'Previous', url_for(page: current_page - 1), class: 'page-link'
      end)

      # Page Number Links
      (1..total_pages).each do |page|
        concat(content_tag(:li, class: "page-item #{'active' if page == current_page}") do
          link_to page, url_for(page: page), class: 'page-link'
        end)
      end

      # Next Page Link
      concat(content_tag(:li, class: "page-item #{'disabled' if current_page == total_pages}") do
        link_to 'Next', url_for(page: current_page + 1), class: 'page-link'
      end)
    end
  end

  # Sorting the contacts by column values(ascending and descending sort by alphabetical order for name and email and numerical order for phone)
  def sortable(column, title = nil)
    title ||= column.titleize  # Use the column name if no title is provided
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"  # Toggle the sort direction
    link_to "#{title} #{sort_arrows(column)}".html_safe, { sort: column, direction: direction }
  end

  # Displays an arrow indicating the current sort direction (▲ for ascending, ▼ for descending).
  def sort_arrows(column)
    asc_arrow = sort_column == column && sort_direction == "asc" ? "▲" : "△"
    desc_arrow = sort_column == column && sort_direction == "desc" ? "▼" : "▽"
    "#{asc_arrow} #{desc_arrow}"
  end
end
