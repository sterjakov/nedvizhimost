# -*- encoding : utf-8 -*-
class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id, :alt, :weight, :title, :meta_key, :meta_description
  has_many :child, :class_name => 'Category', :foreign_key => 'parent_id'
  belongs_to :parent, :class_name => 'Category'

  has_many :posts, dependent: :destroy
  belongs_to :post

  default_scope order('weight DESC, name ASC')

  validates :name, :parent_id, :alt, presence: true
  validates :alt, uniqueness: { case_sensitive: false }

  after_commit :flush_cache

  def flush_cache
    Rails.cache.delete('all_categories')
  end

  def self.all_cached
    Rails.cache.fetch('all_categories'){ self.all }
  end

  # Все дочерние id
  def children_ids
    def render_category category, arr = []
      if category.present?
        category.each do |category|
          arr << category.id
          render_category category.child, arr
        end
      end
      arr
    end

    render_category(self.child) << self.id

  end

end
