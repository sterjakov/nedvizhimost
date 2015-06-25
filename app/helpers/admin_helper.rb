# -*- encoding : utf-8 -*-
module AdminHelper

  # ссылка редактирования
  def admin_edit_link

    separator = '| '
    edit_name = 'Редактировать'


    case action_name


      when 'page'
        url = edit_admin_page_path(@page)
      when 'realty'
        url = edit_admin_house_path(@house, realty_type: (@house.realty_type == 1) ? 'sell' : 'rent')
      when 'post'

        if can 'edit_post' and @post
          url = edit_admin_post_path(@post)
        end

      when 'feedbacks'
        url = admin_feedbacks_path
      when 'posts'
        #edit_name = 'Настройки'

        # Потому что на главной странице нет категорий
        if @category
          url = edit_admin_category_path(@category)
        end

    end

    if url
      link = separator + link_to(edit_name, url)
      link.html_safe
    end
  end

  # меню администратора
  def render_admin_menu

    li = ''

    @admin_menu.each do |menu|

      selected                  = { class: 'blue' } if menu[:selected]

      case menu[:alt]
        when 'exit'
          link                      = link_to('Выйти', '/exit').html_safe
          li << content_tag(:li, link)
        when 'root'
          link                      = link_to('Вернуться на сайт', '/').html_safe
          li << content_tag(:li, link)
          li << content_tag(:hr)
        when 'settings'
          link                      = link_to(menu[:name], { controller: menu[:alt], action: 'edit' }, selected)
          li << content_tag(:li, link)
        else
          count                     = (menu[:count].to_i > 0) ? " <span class='blue'>(#{menu[:count]})</span>" : ''
          link                      = link_to((menu[:name] + count).html_safe, { controller: menu[:alt], "#{menu[:param]}" => menu[:value] }, selected).html_safe
          li << content_tag(:li, link)
          li << content_tag(:hr) if menu[:hr]
      end

    end

    content_tag(:ul, li.html_safe)

  end

  # список категорий для упарвления
  def category_list categories = false

    li = ''
    categories = (categories) ? categories : @categories

    categories.each do |category|

      url = edit_admin_category_path(category[:id])
      delete_link = link_to('[х]', admin_category_path(category), method: :delete, data: { confirm: 'Внимание! Вместе с этой категорией будут удалены все её подкатегории а также вложенные в неё статьи. Удалить?' })

      if category[:parent]
        li << content_tag(:li, link_to(category[:name], url)  + " " + delete_link + category_list(category[:parent]))
      else
        li << content_tag(:li, link_to(category[:name], url) + " " + delete_link)
      end
    end

    content_tag(:ul, li.html_safe).html_safe

  end


  # вернуть массив категорий для f.select
  def categories_for_select root = false
    arr = [['Корневая категория', 0]] + render_categories_for_select
  end


  # рендерим массив категорий для f.select
  private
  def render_categories_for_select categories = false, lvl = 1, arr = []

    categories = (categories) ? categories : @categories

    categories.each do |category|
      arr << [ "-" * lvl+ category[:name], category[:id] ]
      arr += render_categories_for_select(category[:parent], lvl+1) if category[:parent]
    end

    arr

  end


end
