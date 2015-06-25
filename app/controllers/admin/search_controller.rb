# -*- encoding : utf-8 -*-
class Admin::SearchController < AdminController
  layout "admin"

  def index

    @house = House.new(params[:house])

    # Общие условия
    where = { sql: '1 = 1 ', params: {} }
    realty_type = (params[:realty_type] == 'sell') ? 1 : 2
    where[:sql] += 'AND realty_type = :realty_type '
    where[:params][:realty_type] = realty_type

    # Если данные формы пришли
    if params[:house].present?

      # Тип недвижимости
      if params[:house][:apartment_type].present?
        where[:sql] += 'AND apartment_type = :apartment_type '
        where[:params][:apartment_type] = params[:house][:apartment_type]
      end

      # Цена
      if params[:house][:price].present?
        where[:sql] += 'AND price > :price_from AND price < :price_to '
        where[:params][:price_from] = (params[:house][:price].present?)       ? params[:house][:price]       : false
        where[:params][:price_to]   = (params[:house][:price_until].present?) ? params[:house][:price_until] : false
      end

      # Общая площадь
      if params[:house][:square_main].present?
        where[:sql] += 'AND square_main > :square_main_from AND square_main < :square_main_to '
        where[:params][:square_main_from] = (params[:house][:square_main].present?)       ? params[:house][:square_main]       : false
        where[:params][:square_main_to]   = (params[:house][:square_main_until].present?) ? params[:house][:square_main_until] : false
      end

      # Жилая площадь
      if params[:house][:square_live].present?
        where[:sql] += 'AND square_live > :square_live_from AND square_live < :square_live_to '
        where[:params][:square_live_from] = (params[:house][:square_live].present?)       ? params[:house][:square_live]       : false
        where[:params][:square_live_to]   = (params[:house][:square_live_until].present?) ? params[:house][:square_live_until] : false
      end

      # Кухонная лощадь
      if params[:house][:square_kitchen].present?
        where[:sql] += 'AND square_kitchen > :square_kitchen_from AND square_kitchen < :square_kitchen_to '
        where[:params][:square_kitchen_from] = (params[:house][:square_kitchen].present?)       ? params[:house][:square_kitchen]       : false
        where[:params][:square_kitchen_to]   = (params[:house][:square_kitchen_until].present?) ? params[:house][:square_kitchen_until] : false
      end

      # Этаж квартиры
      if params[:house][:floor_apartments].present?
        where[:sql] += 'AND floor_apartments >= :floor_apartments_from AND floor_apartments <= :floor_apartments_to '
        where[:params][:floor_apartments_from] = (params[:house][:floor_apartments].present?)       ? params[:house][:floor_apartments]       : false
        where[:params][:floor_apartments_to]   = (params[:house][:floor_apartments_until].present?) ? params[:house][:floor_apartments_until] : false
      end

      # Кроме последнего
      if params[:house][:but_last] == '1'
        where[:sql] += 'AND floor_apartments >= :floor_apartments_from AND floor_apartments <= :floor_apartments_to AND floor_apartments <> floor_house '
        where[:params][:floor_apartments_from] = (params[:house][:floor_apartments].present?)       ? params[:house][:floor_apartments]       : false
        where[:params][:floor_apartments_to]   = (params[:house][:floor_apartments_until].present?) ? params[:house][:floor_apartments_until] : false
      end

      # Минут до метро
      if params[:house][:metro_time].present?
        where[:sql] += 'AND metro_time >= :metro_time_from AND metro_time <= :metro_time_to '
        where[:params][:metro_time_from] = (params[:house][:metro_time].present?)       ? params[:house][:metro_time]       : false
        where[:params][:metro_time_to]   = (params[:house][:metro_time_until].present?) ? params[:house][:metro_time_until] : false
      end

      # Станции метро
      if params[:house][:metro_station_collection].present? and params[:house][:metro_station_collection] != '[]'
        where[:sql] += 'AND metro_station IN (:metro_station) '
        where[:params][:metro_station] = JSON.parse(params[:house][:metro_station_collection])
      end

    end

    @result = where[:sql]
    @houses = House.where(where[:sql],where[:params]).paginate( page: params[:page])
    #@houses = House.paginate( page: params[:page])

  end
end
