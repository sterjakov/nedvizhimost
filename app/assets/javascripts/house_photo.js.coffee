jQuery ->

  # Фотографии

  hide_speed = 500   # скорость затухания
  photo_limits = 10  # ограничение фотографий

  # Добавить поле
  $('body').delegate '.add_fields', 'click', (event) ->
    console.log 'trololo'
    question_count = $('.photos .field').size()
    limit = photo_limits
    if question_count < limit
      time = new Date().getTime() # получаем метку времени UNIX которую потом азменяем на ID - 1369036309542
      regexp = new RegExp($(this).data('id'), 'g') # формируем строку с регулярным выражением - /95443790/g
      $(this).before($(this).data('fields').replace(regexp, time)) # вставляем перед ссылкой содержание аттрибута data-fileds
      if question_count == limit - 1
        $(this).hide(hide_speed)
    event.preventDefault()

  # Удалить поле
  $('body').delegate '.remove_fields', 'click', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.field').hide(hide_speed)
    $(this).parent('div').removeClass('field')
    if $('.add_fields').css('display') == "none" and $('.photos .field').size() == photo_limits - 1
      $('.add_fields').show(hide_speed)
    event.preventDefault()




  true