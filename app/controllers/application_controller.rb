# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  include SimpleCaptcha::ControllerHelpers
  protect_from_forgery

  helper_method :can, :transliterator

  before_filter :auth?

  def can action
    case action
      when 'edit_post'
        if @user.role > 0
          @user.id == @post.user_id
        else
          true
        end
    end
  end

  def auth?

    if cookies[:auth_token].present?
      if @user = User.where(auth_token: cookies[:auth_token]).first
        @auth = true
      end
    end

  end


  def html_compress()

      html_min = HTMLMin.new
      self.response_body = html_min.minimize(self.response_body[0])
  end

  # Создаём многоуровневый хеш из категорий
  def get_categories categories = [], parent_id = 0

    @categories.each do |category|
      if category.parent_id == parent_id
        categories << { name: category.name, id: category.id, parent_id: category.parent_id, alt: category.alt, action: 'posts' }
        if has_parent?(category)
          categories[-1][:parent] = get_categories([], category.id)
        end
      end

    end
    categories
  end

  # Проверяем наличие потомков у категории
  def has_parent?(category)

    @categories.each do |category_each|
      return true if category.id == category_each.parent_id
    end
    return false
  end


end
