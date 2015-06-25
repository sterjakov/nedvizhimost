ActsAsTaggableOn::Tag.class_eval do
  before_save { |tag| tag.alt = transliterator(name, :english) }

  def to_param
    alt
  end

  def transliterator str, lang
    Translit::convert(str, lang).gsub('#','').gsub('\'', '').gsub(' ', '-')
  end

end