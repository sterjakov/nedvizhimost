# -*- encoding : utf-8 -*-
class Page < ActiveRecord::Base
  attr_accessible :alt, :description, :meta_description, :meta_keywords, :name, :image_alt, :title

  validates :name, :alt, :title, presence: true
  validates :name, :alt, uniqueness: { case_sensitive: false }

end
