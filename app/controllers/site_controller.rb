# -*- encoding : utf-8 -*-


class SiteController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound , with: :e404
  rescue_from ActionController::RoutingError , with: :e404

  attr_accessor :main_menu

  def get_presets
    @adverts             = Advert.all_cached
    @request_path        = request.path.split('/')[-1]
    @settings            = Settings.last_cached
    @categories          = Category.all_cached
    @recent_feedbacks    = Feedback.recent_cached
    @posts_tags          = Post.cached_tags_all
    @main_menu           = get_menu 'main'
    @header_menu         = get_menu 'header'
    @left_menu           = get_menu 'left'
    @title               = @settings[:title]
    @title_postfix       = " | " + @settings[:title_postfix]
    @meta_keywords       = @settings[:meta_keywords]
    @meta_description    = @settings[:meta_description]
    @footer_description  = @settings[:footer_description]
  end

  def e404

    @page = Page.where(alt: '404').first
    render :page, :status => 404

  end

  # Карта сайта
  def get_sitemap xml = false

    if xml

      post = Post.select('alt AS url, updated_at AS lastmod, image').all.each do |post|
        post[:changefreq]  = 'weekly'
        post[:priority]    = '0.8'
        post[:lastmod]     = l(post[:lastmod],  format: :date)
      end

      page = Page .select('alt AS url, updated_at AS lastmod').all.each do |page|
        page[:changefreq]  = 'weekly'
        page[:priority]    = '0.5'
        page[:lastmod]     = l(page[:lastmod],  format: :date)
      end

      # house = House.select('id  AS url, updated_at AS lastmod').all.each do |house|
      #   house[:changefreq] = 'monthly'
      #   house[:priority]   = '0.2'
      #   house[:lastmod]    = l(house[:lastmod], format: :date)
      # end

      @results = sitemap = { post: post, page: page }

    else
      @posts  = Post.find(:all,:select => 'name, alt, category_id')
      sitemap = @header_menu +
                sitemap_with_posts(@main_menu) +
                @left_menu +
                [{name:"Реклама", action: 'page', alt: 'reklama'}]
    end

  end

  def sitemap_with_posts categories, arr = []
    categories.each do |category|

      if(category[:parent])
        arr << { name: category[:name], alt: category[:alt], action: 'posts', parent: sitemap_with_posts(category[:parent])  }
      else
        arr << { name: category[:name], alt: category[:alt], action: 'posts' }
      end

      @posts.each do |post|
        if post[:category_id] == category[:id]
          arr << { name: post[:name], alt: post[:alt], action: 'catalog' }
        end
      end

    end
    arr
  end


  # Карта объектов недвижимости
  def get_yrl
    @yrl = []
    @houses = House::where(status: 1).each do |house|
      category = (house.apartment_type <= 4) ? 'Комната' : 'Квартира'
      rooms    = (house.apartment_type <= 4) ? house.apartment_type + 1 : house.apartment_type - 4
      rooms_offered = (house.apartment_type <= 4) ? house.apartment_type + 1 : 1
      loggia = (house.loggia > 0) ? house.loggia.to_s + " " + Russian::p(house.loggia, 'лоджия', 'лоджии','лоджий') : nil if house.loggia
      balcony = (house.balcon > 0) ? house.balcon.to_s + " " + Russian::p(house.balcon, 'балкон', 'балкона','балконов') : nil if house.balcon
      balcony += " и " + loggia if balcony && loggia
      metro = house.metro.name if house.metro
      
      # Общие данные об объекте
      @yrl << { 
        id: house.id, 
        type: (house.realty_type == 1) ? 'Продажа' : 'Аренда',
        property_type: (house.residential_type == 0) ? 'Жилая' : 'Не жилая',
        category: category,
        creation_date: house.created_at.iso8601,
        last_update_date: house.updated_at.iso8601,
        country: "Россия",
        locality_name: "Москва",
        address: house.address,
        metro_name: metro,
        time_on_transport: house.metro_time_transport,
        time_on_foot: house.metro_time_on_foot,
        agent_name: "Стержакова Елена",
        agent_phone: "8-495-627-6355",
        agent_email: "s9422181@yandex.ru",
        agent_category: "агентство",
        agent_organization: "Недвижимость в Москве",
        agent_url: "http://nedwizhimostwmoskwe.ru/",
        price_value: house.price,
        price_currency: 'RUR', 
        price_period: (house.realty_type == 2) ? 'Месяц' : nil,
        agent_fee: house.comission,
        description: house.description,
        floors_total: house.floor_house,
        url: "http://" + request.host_with_port + "/realty/#{house.id}",
        payed_adv: 1,
        manually_added: 1,
        images: house.photos,
        renovation: (house.apartment_status) ? House::APARTMENT_STATUS[house.apartment_status][0] : nil,
        area_space: house.square_main,
        living_space: house.square_live,
        kitchen_space: house.square_kitchen,
        unit: 'кв. м',
        new_flat: (house.apartment_age == 0) ? "Да" : nil,
        rooms: rooms,
        rooms_offered: rooms_offered,
        rooms_type: (house.room_type) ? House::ROOM_TYPE[house.room_type][0] : nil,
        balcony: balcony || loggia,
        bathroom_unit: (house.bathroom) ? House::BATHROOM[house.bathroom][0] : nil,
        floor: house.floor_apartments,
        building_type: (house.house_type) ? House::HOUSE_TYPE[house.house_type][0] : nil,
        
      } 
      
      # Только объекты аренды
      if(house.realty_type == 2)
        @yrl[-1].merge!({
          rent_pledge: (house.deposit == true) ? 'да' : nil,
          with_pets: (house.animal == true) ? 'да' : nil,
          with_childrens: (house.children == true) ? 'да' : nil,
          room_furniture: (house.furniture_floor == true) ? 'да' : nil,
          kitchen_furniture: (house.furniture_kitchen == true) ? 'да' : nil,
          television: (house.tv == true) ? 'да' : nil,
          washing_mashine: (house.washing_mashine == true) ? 'да' : nil,
          refrigerator: (house.refrigerator == true) ? 'да' : nil,
          })

      # Только объекты продажи      
      elsif(house.realty_type == 1)
        @yrl[-1].merge!({
          mortgage: (house.credit == 0) ? 'да' : (house.credit == 1) ? 'нет' : nil,
          })
      end
      

    end
    @yrl
  end

  # Получаем меню по типу
  def get_menu type = false
    case type
      when 'main'
        @menu = [ { name: 'Каталог', parent: [ { name: 'Аренда недвижимости', action: 'page', alt: 'katalog-arendi' },
                                               { name: 'Продажа недвижимости', action: 'page', alt: 'katalog-prodaji' } ] } ] \
                + get_categories() + [ { name: 'Оставить<br /> заявку'.html_safe, action: 'page', alt: 'kontakti', class: 'make_order'} ]
      when 'header'
        @menu = [ { name: 'О нас',       action: 'page',      alt: 'o-nas',         separator: true,   style: '' },
                  { name: 'Карта сайта', action: 'page',      alt: 'karta-sayta',   br: true,          style: '' },
                  { name: 'Контакты',    action: 'page',      alt: 'kontakti',      separator: true,   style: '' },
                  { name: 'Отзывы',      action: 'otzivi',    alt: false,           br: true,          style: '' } ]
      when 'left'
        @menu = [ { name: 'Разместить объявление',            action: 'page', alt: 'razmestit-obyavlenie' },
                  { name: 'Срочный выкуп квартиры',           action: 'page',      alt: 'srochniy-vikup-kvartiri' },
                  { name: 'Кредит на квартиру',               action: 'page',      alt: 'kredit-na-kvartiru' },
                  #{ name: 'Заказать звонок эксперта',         action: '#',         alt: 'zakazat-zvonok-eksperta' },
                  { name: 'Стоимость<br/> услуг'.html_safe,   action: 'page',      alt: 'stoimost-uslug' },
                  { name: 'Оставить<br/> отзыв'.html_safe,    action: 'page',      alt: 'ostavit-otziv' },]
    end

    set_selected(@menu)

  end

  # Назначаем выбранные пункты меню
  def set_selected menu
    menu.each do |category|
      case category[:action]
        when 'page'
          category[:selected] = 'selected' if params[:alt] == category[:alt]
        when 'razmestit-obyavlenie'
          category[:selected] = 'selected' if @request_path == 'razmestit-obyavlenie'
        when 'posts'
          category[:selected] = 'selected' if params[:category] == category[:alt]
        when 'catalog'
          category[:selected] = 'selected' if @request_path == category[:alt]
        when 'otzivi'
          category[:selected] = 'selected' if action_name == 'feedbacks'
      end

      set_selected(category[:parent]) if category[:parent]

    end
  end


end
