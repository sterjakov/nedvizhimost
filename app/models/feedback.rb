# -*- encoding : utf-8 -*-
class Feedback < ActiveRecord::Base

  self.per_page = 15

  apply_simple_captcha

  default_scope order('status, created_at DESC')

  attr_accessible :author, :description, :status, :captcha, :captcha_key

  validates :author, :description, :status, presence: true

  after_commit :flush_cache

  def flush_cache
    Rails.cache.delete('recent_feedbacks')
  end

  def self.recent_cached
    Rails.cache.fetch('recent_feedbacks'){ self.where(status: 1).last(3) }
  end


end
