# -*- encoding : utf-8 -*-
class Tag < ActiveRecord::Base

  before_save :set_alt

  def set_alt
    debugger
  end

end
