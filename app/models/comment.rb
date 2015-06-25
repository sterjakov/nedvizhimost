# -*- encoding : utf-8 -*-
class Comment < ActiveRecord::Base

  self.per_page = 15

  apply_simple_captcha

  default_scope order('status, created_at DESC')

  attr_accessible :description, :email, :post_id, :author, :status, :captcha, :captcha_key

  belongs_to :post, foreign_key: 'post_id'

  validates :author, :description, :email, :post_id, :status,
            presence: true

  validates :email,
            :length => {:minimum => 3, :maximum => 254},
            :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}


end
