# -*- encoding : utf-8 -*-
class Post < ActiveRecord::Base

  self.per_page = 30

  acts_as_taggable

  mount_uploader :image, PostUploader

  attr_accessor :image_crop, :mini_image_crop, :image_file_name, :image_asset_file_name, :image_content_type,
                :image_file_size, :image_updated_at, :original_file_path, :remove_image

  attr_accessible :category_id, :description, :meta_description, :meta_key, :name, :tag_list, :alt, :image,
                  :mini_image, :benefits, :image_crop, :mini_image_crop, :image_file_name, :image_asset_file_name,
                  :image_content_type, :image_file_size, :image_updated_at, :original_file_path, :remove_image,
                  :image_alt, :title, :created_at

  has_many :link
  has_one :category, foreign_key: 'id'
  has_many :comment
  belongs_to :category
  belongs_to :user

  validates :description, :name, :category_id, :alt, :title, presence: true
  validates :name, :alt, uniqueness: { case_sensitive: false }

  after_destroy :destroy_thumb_folder
  after_save :check_destroy_thumb_folder
  after_validation :delete_tmp_folder

  after_commit :flush_cache

  def flush_cache
    Rails.cache.delete('tags_all')
  end



  def delete_tmp_folder
    if self.errors.present? # если валидация не удалась

      if self.image.present?
        cache_folder = self.image.url.split('/')[3]
        FileUtils.rm_rf('public/uploads/tmp/' + cache_folder)
      end

    end
  end

  def check_destroy_thumb_folder
    if self.remove_image == '1'
      puts destroy_thumb_folder
    end
  end

  def destroy_thumb_folder
    id_post  = id.to_s
    FileUtils.rm_rf('public/uploads/post/image/' + id_post)
  end

  default_scope order('created_at DESC')



  def self.cached_tags_all
    Rails.cache.fetch('tags_all') do
      tag_counts_on(:tags).to_a
    end
  end

end
