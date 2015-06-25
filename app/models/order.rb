# -*- encoding : utf-8 -*-
class Order < ActiveRecord::Base

  self.per_page = 50

  apply_simple_captcha

  default_scope order('status, created_at DESC')

  belongs_to :house

  attr_accessible :author, :description, :email, :phone, :status, :captcha, :captcha_key, :house_id

  validates :author, :description, :email, :status, presence: true

  validates :phone,
            length: { in: 7..25 },
            format: { with: /^[\(\)0-9\- \+\.]{10,20} *[extension\.]{0,9} *[0-9]{0,5}$/i}

  validates :email,
            length: { in: 3..254 },
            format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}

end
