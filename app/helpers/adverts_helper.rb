module AdvertsHelper


  # Получаем рекламный блок
  def get_block position

    @adverts.map do |v|
      return v.description.html_safe if v.position == get_position_number(position)
    end

    false

  end

  def get_position_number name

    Advert::POSITION.map do |k,v|
      return v if k == name
    end

    false

  end

end
