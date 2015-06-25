# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->

  # Станции метро

  ids = []

  # Загрузить или перезагрузить коллекцию станций
  metro_collect_reload = () ->
    if !($('#house_metro_collection').attr('value') == undefined) and !($('#house_metro_collection').attr('value') == '') # Если значения есть
      console.log $('#house_metro_collection').attr('value')
      metro_collection = jQuery.parseJSON($('#house_metro_collection').attr('value'))
      jQuery.each(metro_collection, (index, value) ->
        ids.push(value)
        found_option = $('#house_metro_id option[value="' + value + '"]')
        $('#house_metro_selected').append(found_option)
      )

  metro_collect_reload()

  # Обновить поле с коллекцией id метро
  metro_collect_update = (ids) ->
    console.log JSON.stringify(ids)
    $('#house_metro_collection').attr('value',JSON.stringify(ids))

  # Кнопка "Добавить"
  $('.multiple .add').click ->
    $('#house_metro_id option:selected').each ->
      ids.push($(this).attr('value'))
      $('#house_metro_selected').append($(this))
    metro_collect_update(ids)

  # Кнопка "Удалить"
  $('.multiple .remove').click ->
    $('#house_metro_selected option:selected').each ->
      ids.splice($.inArray($(this).attr('value'), ids),1);
      $('#house_metro_id').append($(this))
    metro_collect_update(ids)

  metro_clear = () ->
    ids = []
    $('#house_metro_selected option').each ->
      $('#house_metro_id').append($(this))
    metro_collect_update(ids)

  # Кнопка "Очистить поле"
  $('.clear_metro').click ->
    metro_clear()

  # Кнопка "Очистить все поле"
  $('.clear_all').click ->
    metro_clear()
    $('#house_code, #house_apartment_type, #house_realty_type, #house_realty_type_until, #house_price,
       #house_price_until, #house_square_main, #house_square_main_until, #house_square_kitchen,
       #house_square_kitchen_until, #house_square_live, #house_square_live_until, #house_floor_apartments,
       #house_floor_apartments_until, #house_but_last, #house_metro_time, #house_metro_time_until')
      .val('').removeAttr('checked').removeAttr('selected');
  true