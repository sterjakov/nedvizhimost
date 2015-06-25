# -*- encoding : utf-8 -*-
class Contact < ActiveRecord::Base
  apply_simple_captcha

  attr_accessible :author, :description, :email, :phone, :captcha, :captcha_key

  validates :description, :phone, presence: true

  validates :phone,
            length: { in: 7..25 },
            format: { with: /^[\(\)0-9\- \+\.]{7,20} *[extension\.]{0,9} *[0-9]{0,5}$/i}

  validates :email,
            :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i},
            :allow_blank => true

end
