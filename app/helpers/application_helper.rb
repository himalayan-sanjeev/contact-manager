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
end
