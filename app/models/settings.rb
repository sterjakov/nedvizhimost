# -*- encoding : utf-8 -*-
class Settings < ActiveRecord::Base
  attr_accessible :email, :footer_description, :meta_description, :meta_keywords, :similar_posts_count, :title,
                  :title_postfix, :main_head

  validates :email,
            length: { in: 3..254 },
            format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}

  validates :email, :footer_description, :meta_description, :meta_keywords, :similar_posts_count, :title,
            :title_postfix, :main_head,
            presence: true


  after_commit :flush_cache

  def flush_cache
    Rails.cache.delete('last_settings')
  end

  def self.last_cached
    Rails.cache.fetch('last_settings'){ self.last }
  end

end
