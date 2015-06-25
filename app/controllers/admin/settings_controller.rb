# -*- encoding : utf-8 -*-
class Admin::SettingsController < AdminController
  def edit
    unless @settings = Settings.last
      @settings = Settings.create({
          title:               'Главная страница',
          title_postfix:       'Недвижимость в Москве',
          meta_keywords:       'Недвижимость, каталог, Москва',
          meta_description:    'Каталог недвижимость в Москве',
          email:               's9422181@yandex.ru',
          footer_description:  '2013г. Все права защищены. Недвижимость в Москве. ',
          similar_posts_count: 10
                                  })
    end
  end

  def update
   
    @settings = Settings.find(params[:settings][:id])

    respond_to do |format|
      if @settings.update_attributes(params[:settings])
        format.html { redirect_to '/admin/settings/edit', notice: 'Настройки успешно обновлены.' }
      else
        format.html { render action: "edit" }
      end
    end

  end

end