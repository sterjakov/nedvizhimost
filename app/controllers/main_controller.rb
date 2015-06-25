# -*- encoding : utf-8 -*-
class MainController < SiteController

  before_filter :get_presets
  after_filter :html_compress

  before_filter :redirect_www, only: [:posts]

  # Редиректим если www указан для главной страницы
  def redirect_www


    if request.env['PATH_INFO'] == '/' and /www/ === request.host

      redirect_to 'http://' + request.host.gsub('www.', ''), status: 301

    end
  end

  # Все статьи (Главная страница)
  def posts

    if params[:tag].present?
      @tag       = ActsAsTaggableOn::Tag.find_by_alt(params[:tag])
      @posts    = Post.tagged_with(@tag).paginate( page: params[:page], per_page: 10 )
      @title_pagination = (params[:page].to_i > 1) ? " (страница #{params[:page]})" : ''
      @title    = @tag.name.to_s + @title_pagination + @title_postfix

      render status: '404' if @posts.length == 0
    elsif params[:category].present?
      @category = Category.where( alt: params[:category] ).first
      raise ActiveRecord::RecordNotFound if !@category
      @title_pagination = (params[:page].to_i > 1) ? " (страница #{params[:page]})" : ''
      @title            = @category.title.to_s + @title_pagination + @title_postfix
      @meta_keywords    = @category.meta_key
      @meta_description = @category.meta_description
      @posts    = Post.where(category_id: @category.children_ids).paginate( page: params[:page], per_page: 10 )
    else
      @posts    = Post.paginate( page: params[:page], per_page: 10 ).to_a
    end

  end

  # Просмотр статьи
  def post

    @links = Link.all

    #expire_page('/')
    #expire_page(action: 'page', controller: 'main')

    @post = Post.where( alt: params[:alt] ).first
    raise ActiveRecord::RecordNotFound if !@post
    @comment          = @post.comment.new(params[:comment])
    @comment[:status] = 0 # на модерации
    @comments         = @post.comment.where(status: 1).paginate(page: params[:page])
    @similar_posts    = Post.where("#{Post.table_name}.id not in (?)",[@post.id])
    .tagged_with( @post.tag_list, any: true )
    .limit(@settings[:similar_posts_count])


    # POST
    if params[:comment].present?
      if @comment.save_with_captcha
        Notifier.comment(@comment).deliver
        redirect_to(main_post_url(alt: params[:alt], anchor: "notice"), flash: { notice: 'Ваш комментарий был успешно отправлен на модерацию.' })
      end
    end

  end

  # Каталог недвижимости
  def catalog
    @house = House.new(params[:house])
    @realty_type = @house.realty_type_number(@request_path)

    where_sql = "realty_type = :realty_type "
    where_params = { realty_type: @realty_type }

    # POST
    if params[:house].present?

      # код предложения
      if params[:house][:code].present?
        where_sql += "AND id = :code "
        where_params[:code] = params[:house][:code]
      end

      # тип недвижимости
      if params[:house][:apartment_type].present?
        where_sql += "AND apartment_type = :apartment_type "
        where_params[:apartment_type] = params[:house][:apartment_type]
      end

      # цена, этаж квартиры, минут до метро
      %w(price floor_apartments metro_time_on_foot metro_time_transport).map do |attr|

          from, to = params[:house][:"#{attr}"], params[:house][:"#{attr}_until"]

          # Если присутствуют оба параметра
          if from.present? && to.present?

            where_sql += "AND #{attr} >= :#{attr} AND #{attr} <= :#{attr}_until "
            where_params[:"#{attr}"] = from
            where_params[:"#{attr}_until"] = to

          # Если значение "от" присутствует, а значение "до" отсутствует
          elsif from.present? && to.empty?

            where_sql += "AND #{attr} >= :#{attr} "
            where_params[:"#{attr}"] = from

          # Если значение "от" отсутствует, а значение "до" присутствует
          elsif from.empty? && to.present?

            where_sql += "AND #{attr} <= :#{attr}_until "
            where_params[:"#{attr}_until"] = to

          end

      end

      # кроме последнего этажа
      if params[:house][:but_last] == '1'
        where_sql += "AND floor_apartments NOT IN ('#{House.table_name}'.floor_house) "
      end

      # общая, жилая, кухни площадь
      %w(main live kitchen).map do |prefix|
        if params[:house]["square_#{prefix}"].present?
          where_sql += "AND square_#{prefix} >= :square_#{prefix} AND square_#{prefix} <= :square_#{prefix}_until "

          where_params[:"square_#{prefix}"] = params[:house]["square_#{prefix}"]
          where_params[:"square_#{prefix}_until"] = params[:house]["square_#{prefix}_until"]
        end
      end

      # метро
      if params[:house][:metro_collection].present? and params[:house][:metro_collection] != '[]'
        where_sql += "AND metro_id IN (:metro_collection) "
        where_params[:metro_collection] = JSON.parse(params[:house][:metro_collection])
      end

    end

    @houses = House.where(where_sql, where_params).paginate( page: params[:page], per_page: 18 )

  end

  # Карточка каталога
  def realty
    @house = House.find(params[:id])
    @order = @house.order.new(params[:order])
    @order.status = 0 # на модерации

    # POST
    if params[:order].present?
      if @order.save_with_captcha
        Notifier.order(@order).deliver
        redirect_to(main_realty_url(id: params[:id]), flash: { notice: 'Ваш заказ успешно отправлен. В ближайшее время наш специалист свяжется с вами.' })
      end
    end
  end

  # Добавить в каталог
  def add_realty
    @house = House.new(params[:house])
    @house.status = 0 # на модерации
    @photos = @house.photos

    # POST
    if params[:house].present?
      if @house.save_with_captcha
        Notifier.house(@house).deliver
        redirect_to(main_add_realty_url, flash: { notice: 'Ваша заявка успешно отправлена. В ближайшее время наши специалисты рассмотрят её и добавят в каталог.' })
      else
        photo = @house.photos.build unless @photos.present?
      end
    else
      photo = @house.photos.build
    end
  end

  # Страница (Категория страниц)
  def page

    # Если в строке есть katalog-arendi или katalog-prodaji params[:alt] = str.

    @page = Page.where(alt: params[:alt]).first
    raise ActiveRecord::RecordNotFound if !@page

    if params[:alt] == 'kontakti'
      @contact = Contact.new
    end

    # POST
    if params[:contact].present?
      @contact = Contact.new(params[:contact])
      if @contact.valid_with_captcha?
        if @mail = Notifier.contact(@contact).deliver
          redirect_to(main_page_url(alt: params[:alt]), anchor: "notice", flash: { notice: 'Ваше сообщение успешно доставлено.' })
        end
      end
    end

    if params[:alt] == 'karta-sayta'
      @sitemap = get_sitemap
    end

    if params[:alt] == 'ostavit-otziv'
      @feedback = Feedback.new(params[:feedback])
      @feedback.status = 0 # на модерации

      # POST
      if params[:feedback].present?
        if @feedback.save_with_captcha
          Notifier.feedback(@feedback).deliver
          redirect_to(main_page_url(alt: params[:alt]), anchor: "notice", flash: { notice: 'Ваш отзыв успешно сохранен.' })
        end
      end
    end

    if params[:alt] == 'razmestit-obyavlenie'

      @house = House.new(params[:house])
      @house.status = 0 # на модерации
      @photos = @house.photos

      # POST
      if params[:house].present?
        if @house.save_with_captcha
          Notifier.house(@house).deliver
          redirect_to(main_add_realty_url, flash: { notice: 'Ваша заявка успешно отправлена. В ближайшее время наши специалисты рассмотрят её и добавят в каталог.' })
        else
          photo = @house.photos.build unless @photos.present?
        end
      else
        photo = @house.photos.build
      end

    end

    if params[:alt] == 'katalog-arendi' or params[:alt] == 'katalog-prodaji' or params[:house]
      catalog
    end

  end

  # Каталог отзывов
  def feedbacks
    @feedbacks = Feedback.where(status: 1).paginate( page: params[:page])
  end

  # Карта сайта
  def sitemap
    @sitemap = get_sitemap true
  end

  # Ajax форма дял контактов
  def contact_form

    @contact = Contact.new(params[:contact])
    render(template: 'admin/contacts/_form', layout: false)

  end

  # Карта объектов недвижимости для Яндекса
  def yrl
    @yrl = get_yrl
  end


end
