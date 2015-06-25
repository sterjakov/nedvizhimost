# -*- encoding : utf-8 -*-
class Photo < ActiveRecord::Base
  attr_accessible :house_id, :image
  belongs_to :house
  mount_uploader :image, HouseUploader

  # after_create :watermark
  after_destroy :delete_image_folders

  # def watermark
  #   byebug
  # end


  def delete_image_folders
    id_image  = id.to_s
    FileUtils.rm_rf('public/uploads/photo/image/' + id_image)
  end
end
