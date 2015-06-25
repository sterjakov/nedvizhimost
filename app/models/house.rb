# -*- encoding : utf-8 -*-
class House < ActiveRecord::Base

  self.per_page = 30

  apply_simple_captcha

  default_scope order('status, created_at DESC')

  # Разрешенные атрибуты
  attr_accessible :realty_type, :address, :animal, :apartment_age, :apartment_status, :apartment_type, :balcon, :bathroom,
                  :children, :comission, :credit, :deposit, :description, :email, :fio, :floor_apartments, :floor_house,
                  :furniture_floor, :furniture_kitchen, :furniture_status, :house_type, :loggia, :metro_id,
                  :period, :phone, :price, :refrigerator, :residential_type, :room_type, :sell_type, :square_kitchen,
                  :square_live, :square_main, :tv, :washing_mashine, :windows, :photos_attributes, :fields_type, :status,
                  :price_until, :square_main_until, :square_live_until, :square_kitchen_until, :but_first, :but_last,
                  :fields_type, :floor_apartments_until, :metro_time_until, :metro_selected, :metro_collection,
                  :captcha, :captcha_key, :thumb, :code, :order, :metro_time_transport, :metro_time_transport_until,
                  :metro_time_on_foot, :metro_time_on_foot_until, :created_at

  # Разрешенные атрибуты которых нет в модели
  attr_accessor :price_until, :but_last, :fields_type, :square_main_until, :square_live_until, :square_kitchen_until,
                :floor_apartments_until, :metro_selected, :metro_collection, :code, :metro_time_on_foot_until,
                :metro_time_transport_until

  # Содержит много фотографий
  has_many :photos, dependent: :destroy

  # Содержит много заказов
  has_many :order

  # Содержит много станций метро
  belongs_to :metro

  # Разрешаем вложенные атрибуты для фотографий
  accepts_nested_attributes_for :photos, :reject_if => :all_blank, allow_destroy: true

  # Общие правила валидации
  validates :floor_house, :apartment_type, :address, :square_main, :square_live, :price, :fio, :phone,
            :residential_type,
            presence: true

  validates :status,
            presence: true,
            inclusion: { in: [ 0,1 ]}

  # Сценарий валидации для каталога аренды
  with_options if: :is_rent? do |rent|
    rent.validates :period,
                   presence: true
  end

  def is_rent?
    self.fields_type == '2'
  end

  # Сценарий валидации для каталога продажи
  with_options :if => :is_sell? do |rent|
  end

  def is_sell?
    self.fields_type == '1'
  end

  after_destroy :destroy_image_folder
  after_save :thumb_update

  def realty_type_number params
    case params
      when 'rent'
        2
      when 'sell'
        1
      when 'katalog-arendi'
        2
      when 'katalog-prodaji'
        1
    end
  end

  def catalog
    case realty_type
      when 1
        { name: "Каталог продажи", alt: "katalog_prodaji" }
      when 2
        { name: "Каталог аренды", alt: "katalog_arendi" }
    end
  end

  def thumb_update
    photos.each_with_index do |photo,index|
      self.update_column('thumb', photo[:id].to_s + '/thumb_' + photo[:image] ) if index == 0
    end if photos.present?
  end

  def destroy_image_folder
    id_post  = self.id.to_s
    FileUtils.rm_rf('public/uploads/house/image/' + id_post)
  end

  # Предустановленные значения полей

  STATUS = [
      ['На модерации',0],
      ['Опубликовано',1],
  ]

  FIELDS_TYPE = [
      ['Каталог аренды',2],
      ['Каталог продажи',1],
  ]

  APARTMENT_TYPE = [
      ['Однокомнатная квартира',0],
      ['Двухкомнатная квартира',1],
      ['Трехкомнатная квартира',2],
      ['Четрыехкомнатная квартира',3],
      ['Пять или более комнат',4],
      ['',5],
      ['Одна комната из двух',6],
      ['Одна комната из трех',7],
      ['Одна комната из четырех',8],
      ['Одна комната из пяти и более',9],
  ]

  APARTMENT_AGE = [
      ['Новостройка',0],
      ['Вторичное жилье',1],
  ]

  HOUSE_TYPE = [
      ['Монолитный',0],
      ['Кирпичный',1],
      ['Панельный',2],
      ['Блочный',3],
      ['Сталинский',4],

  ]

  APARTMENT_STATUS = [
      ['Без ремонта',0],
      ['Требует ремонта',1],
      ['Жилое состояние',2],
      ['Отличное состояние',3],
      ['Евроремонт',4],
  ]

  ROOM_TYPE = [
      ['Изолированные',0],
      ['Смежные',1],
  ]

  BATHROOM = [
      ['Совмещенный',0],
      ['Разделенный',1],
  ]

  WINDOWS = [
      ['На улицу',0],
      ['Во двор',1],
      ['Во двор и на улицу',2],
  ]

  SELL_TYPE = [
      ['Свободная',0],
      ['Альтернативная',1],
  ]

  CREDIT = [
      ['Можно ипотеку',0],
      ['Нельзя ипотеку',1],
  ]

  RESIDENTIAL_TYPE = [
      ['Жилое',0],
      ['Не жилое',1],
  ]

  PERIOD = [
      ['Длительный срок (более полугода)',0],
      ['Месячный (несколько месяцев)',1],
      ['Суточный (менее месяца)',2],
  ]

  FURNITURE_STATUS = [
      ['Нет мебели',0],
      ['Современная',1],
      ['Не современная',2],
  ]

  YES = [
      ['Да',0],
      ['Нет',1]
  ]

end
