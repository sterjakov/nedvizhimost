class Advert < ActiveRecord::Base
  attr_accessible :description, :name, :position

  validates :position, :name, presence: true

  after_commit :flush_cache

  def flush_cache
    Rails.cache.delete('all_adverts')
  end

  def self.all_cached
    Rails.cache.fetch('all_adverts'){ self.all }
  end

  def get_position
    POSITION.map{ |k,v| return k if v == self.position.to_i }
  end

  POSITION = [
      ['left',0],
      ['right',1],
      ['post',2],
      ['bottom',3],
      ['body',4],
  ]
end
