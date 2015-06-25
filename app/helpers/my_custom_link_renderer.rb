# -*- encoding : utf-8 -*-
class MyCustomLinkRenderer < WillPaginate::ActionView::LinkRenderer

  def initialize(options = false)
    @options = options
  end

  protected

  def page_number(page)
    unless page == current_page

      if @options[:realty_type] == 1
        link(page, "katalog-prodaji?page=#{page}", :rel => rel_value(page))
      elsif @options[:realty_type] == 2
        link(page, "katalog-arendi?page=#{page}", :rel => rel_value(page))
      else
        link(page, page, :rel => rel_value(page))
      end

    else
      page
    end
  end

  def html_container(html)
     tag(:div, '', style: 'width: 100%; height: 18px;') + tag(:p, 'Страницы', class: 'gray bottom') +
         tag(:div, '',  style: 'width: 100%; height: 4px;') + tag(:div, tag(:div, html, class: 'offset'), class: 'pagination block' )
  end

end
