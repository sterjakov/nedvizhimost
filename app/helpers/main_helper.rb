# -*- encoding : utf-8 -*-
module MainHelper


  # заменяем слова на ссылки со словами
  def links_in_post links, post


    # Удаляем из массива совпадающие с этой статьей ссылки

    post.link.each do |link|

      links.delete_if { |l| l.name == link.name }

    end

    # Заменяем слова на ссылки в тексте статьи
    description = post.description

    links.each do |link|

      description = description.gsub(/#{link.name}/i, "<a href='#{link.url}'>#{link.name}</a>")

    end

    # Статья с замененными словами
    description.html_safe

  end


  # Генерируем url для link_to
  def generate_url category

    case category[:action]
      when 'page'
        url  =  url_for("/page/#{category[:alt]}")
      when 'razmestit-obyavlenie'
        url  =  url_for("/razmestit-obyavlenie")
      when 'otzivi'
        url  =  url_for("/otzivi")
      when 'catalog'
        url = url_for("/" + category[:alt])
      when 'posts'
        url = url_for("/category/#{category[:alt]}")
      when '#'
        url  =  url_for('#')
      else
        url = '#no-action'
    end

  end

  # карта сайта
  def site_map sitemap = false

    sitemap = (sitemap) ? sitemap : @site_map

    li = ''

    sitemap.each do |category|

      url  = generate_url(category)
      link = link_to(strip_tags(category[:name]), url)

      link += site_map(category[:parent]) if category[:parent].present?

      if(category[:action] == 'catalog')
        li += content_tag(:li, link, class: 'gray')
      else
        li += content_tag(:li, link)
      end



    end

    content_tag(:ul, li.html_safe, class: 'sitemap')


  end

  # рендерим меню в левом сайдбаре
  def left_menu

    menu = ''

    @left_menu.each do |category|

      url = generate_url(category)

      case category[:action]
        when 'page'
          menu << link_to(category[:name], url,  class: "#{category[:selected]} #{category[:alt]}")
        when 'razmestit-obyavlenie'
          menu << link_to(category[:name], url,  class: "#{category[:selected]} razmestit-obyavlenie")
          menu << content_tag(:span, 'Бесплатно', class: 'free')
      end

    end

    menu.html_safe

  end


  # рендерим меню хеадера
  def header_menu

    menu = ''

    @header_menu.each do |category|

      url = generate_url(category)

      case category[:action]
        when 'page'
          menu << link_to(category[:name], url, class: "gray #{category[:selected]}")
          menu << '<span style="margin: 0px 12px;">|</span>'    if category[:separator]
          menu << '<br>' if category[:br]
        when 'otzivi'
          menu << link_to(category[:name], url, class: "gray #{category[:selected]}")
      end
    end

    menu.html_safe

  end

  # рендерим главное меню
  def main_menu menu = false

    li = ''
    menu = (menu) ? menu : @main_menu
    menu.each do |category|

      url  = generate_url(category)
      link = link_to( category[:name], url, class: "#{category[:class]} #{category[:selected]}").html_safe

      # если есть наследники
      if category[:parent].present?
        li += content_tag(:li, link + main_menu(category[:parent]))
      else
        li += content_tag(:li, link)
      end
    end

    content_tag( :ul, li.html_safe  )

  end

  def category_parents category, arr = []
    arr << category
    category_parents category.parent, arr if category.parent.present?
    arr.reverse
  end

  # Рендерим категории для меню
  def categories_list_form_menu parent_id = 0, lvl = 1, str = ''
    @categories.each do |category|

      if category.parent_id == parent_id

        children = (category.child.present?) ? content_tag(:ul, categories_list_form_menu(category.id, lvl+1)) : ''
        style_name = (category.child.present? && lvl == 2) ? 'drop' : ''

        li = content_tag( :li, link_to(category.name, main_posts_path(category: category.alt)) + children, class: style_name )
        str << li

      end
      ul = content_tag(:ul, str)
    end

    str.html_safe
  end

end
