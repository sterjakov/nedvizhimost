# -*- encoding : utf-8 -*-

class PostUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file

  before :store, :remember_cache_id
  after :store, :delete_tmp_dir
  after :store, :delete_original_file

  def watermark
    manipulate! do |img|
      logo = Magick::Image.read("#{Rails.root}/public/images/watermark_min.png").first
      img = img.composite(logo, Magick::CenterGravity, Magick::OverCompositeOp) 
      img.write('composite.png')
    end
  end

  # store! nil's the cache_id after it finishes so we need to remember it for deletion
  def remember_cache_id(new_file)
    @cache_id_was = cache_id
  end

  def delete_tmp_dir(new_file)
    # make sure we don't delete other things accidentally by checking the name pattern
    if @cache_id_was.present? && @cache_id_was =~ /\A[\d]{8}\-[\d]{4}\-[\d]+\-[\d]{4}\z/
      FileUtils.rm_rf(File.join(root, cache_dir, @cache_id_was))
    end
  end

  # Удаляем оригинальный файл
  def delete_original_file(new_file)
    File.delete path if version_name.blank?
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :crop
    resize_to_limit(565, 200)
    process :watermark
  end

  version :similar do
    #process :crop
    process :resize_to_fill => [185,133]
  end

  def crop
    target = JSON.parse(model.image_crop)

    if target['x'].present?
      manipulate! do |img|
        x = target['x'].to_i
        y = target['y'].to_i
        w = target['w'].to_i
        h = target['h'].to_i
        img.crop!(x, y, w, h)
      end
    end
  end


end
