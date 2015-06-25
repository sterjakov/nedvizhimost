# -*- encoding : utf-8 -*-
class AdminController < ApplicationController

  before_filter :get_presets, :admin?, except: [:login, :auth]

  def admin?

    unless ['auth','login','exit'].include?(action_name)

      if @user

        if @user.role.to_i == 1
          redirect_to admin_path unless ['posts'].include?(controller_name)
        end

      else
        redirect_to admin_path
      end
    end

  end

  def get_presets
    @admin_menu = get_admin_menu if @user
  end

  # Меню администратора
  def get_admin_menu


    case @user.role.to_i
      when 0
        @menu =
            { name: 'Вернуться на сайт',  alt: 'root',         hr: true },
                { name: 'Статьи',             alt: 'posts' },
                { name: 'Категории',          alt: 'categories',   hr: true },
                { name: 'Заказы',             alt: 'orders',       count: Order.where(status: 0).count },
                { name: 'Комментарии',        alt: 'comments',     count: Comment.where(status: 0).count },
                { name: 'Отзывы',             alt: 'feedbacks',    count: Feedback.where(status: 0).count },
                { name: 'Каталог Аренды',     alt: 'houses',       count: House.where(status: 0, realty_type: 2).count, param: 'realty_type',    value: 'rent' },
                { name: 'Каталог Продажи',    alt: 'houses',       count: House.where(status: 0, realty_type: 1).count, param: 'realty_type',    value: 'sell',    hr: true },
                { name: 'Пользователи',       alt: 'users' },
                { name: 'Ссылки в статьях',   alt: 'links' },
                { name: 'Страницы',           alt: 'pages' },
                { name: 'Станции метро',      alt: 'metros',      hr: true },
                { name: 'Рекламные блоки',    alt: 'adverts' },
                { name: 'Настройки',          alt: 'settings' },
                { name: 'Выйти',              alt: 'exit' }
      when 1
        @menu =
                { name: 'Вернуться на сайт',  alt: 'root',         hr: true },
                { name: 'Статьи',             alt: 'posts' },
                { name: 'Выйти',              alt: 'exit' }
    end





    @menu.each_with_index do |menu,index|
      if menu[:alt] == controller_name
        if params[:"#{menu[:param]}"].present?
          @menu[index][:selected] = true if params[:"#{menu[:param]}"] == menu[:value]
        else
          @menu[index][:selected] = true
        end
      end
    end

  end

end
