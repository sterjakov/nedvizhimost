# -*- encoding : utf-8 -*-
class Notifier < ActionMailer::Base
  default from: "s9422181@yandex.ru", to: (to = Settings.last) ? to[:email] : 's9422181@yandex.ru'

  def order order
    @order = order
    mail(subject: 'Недвижимость в Москве: Новый заказ')
  end

  def contact contact
    @contact = contact
    mail(subject: 'Недвижимость в Москве: Новое сообщение')
  end

  def house house
    @house = house
    mail(subject: 'Недвижимость в Москве: Запрос на добавление в каталог')
  end

  def comment comment
    @comment = comment
    mail(subject: 'Недвижимость в Москве: Новый комментарий ожидает проверки')
  end

  def feedback feedback
    @feedback = feedback
    mail(subject: 'Недвижимость в Москве: Новый отзыв')
  end

end
