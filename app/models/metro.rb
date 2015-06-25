# -*- encoding : utf-8 -*-
class Metro < ActiveRecord::Base
  attr_accessible :name

  has_one :house

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }

  default_scope order('name ASC')

end
