# -*- encoding : utf-8 -*-
module Admin::HousesHelper
  def url_for_house_form house, realty_type
    if action_name == 'edit' or action_name == 'update'
      admin_house_path(house, params: { realty_type: realty_type })
    else
      admin_houses_path(house, params: { realty_type: realty_type })
    end
  end
end
