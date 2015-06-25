# -*- encoding : utf-8 -*-
class Link < ActiveRecord::Base
  attr_accessible :name, :url, :post_id

  belongs_to :post
end
