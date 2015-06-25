# -*- encoding : utf-8 -*-
module ApplicationHelper

  # change the default link renderer for will_paginate
  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end
    unless options[:renderer]
      options = options.merge :renderer => MyCustomLinkRenderer.new(options)
    end
    super *[collection_or_options, options].compact
  end


  # Добавить поле с изображением

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render("/admin/houses/" + association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#add_photo_field', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

end
