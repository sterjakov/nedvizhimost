# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->

  # Счетчик meta-description counter
  $('#page_meta_description, #post_meta_description, #admin_settings_update_meta_description').jqEasyCounter(
    'maxChars': 160,
    'maxCharsWarning': 140,
    'msgFontSize': '16px',
    'msgFontColor': '#939393',
    'msgFontFamily': 'Arial',
    'msgTextAlign': 'center',
    'msgWarningColor': '#F00',
    'msgAppendMethod': 'insertAfter'
  )


  # Кадрирование изображения

  # Параметры
  jcrop_api = null
  options = {
    setSelect:   [ 565, 200, 0, 0 ],
    aspectRatio: 113 / 40
    allowSelect: false,
    boxWidth: 627,
    minSize: [ 565,200 ],
    onChange: (coords) ->
      $('#post_image_crop').attr('value',JSON.stringify(coords))
      if coords['w'] == 0
        jcrop_api.setSelect([565, 200, 0, 0])

    onSelect: (coords) ->
      $('#post_image_crop').attr('value',JSON.stringify(coords))
      console.log coords
  }

  # Клик по "Отменить"
  $('body').delegate '#cancel_crop', 'click', (e) ->
    $('#post_image').val('')
    $('#cancel_crop').remove()
    jcrop_api.destroy()

  # Изменение поля для загрузки фотографий
  $('body').delegate '#post_image', 'change', (e) ->
    readURL this

  readURL = (input) ->
    if input.files and input.files[0]

      # Читаем временно загруженный файл
      reader = new FileReader()
      reader.onload = (e) ->
        img_src = e.target.result # адрес временной картинки

        img = new Image()
        img.onload = () ->

          # Валидация размеров
          if this.width > 565 and this.height > 200

            $(".crop.field").prepend('<div id="image_crop"></div>')
            $("#image_crop").before('<div id="cancel_crop" style="width: 627px; padding: 10px 0px; margin-bottom: 5px;
                                     background-color: #eeeeee; text-align: center; cursor: pointer;">Отменить</div>')
            $("#image_crop").html('<img style="width: 627px; margin-bottom: 20px;" /><div class="clear"></div>')
            $("#image_crop img").attr({ 'src' : img_src })

            $('#image_crop').Jcrop(options, () ->
              jcrop_api = this
            )

            console.log 'yes'

            jcrop_api.setImage(img_src)
            jcrop_api.setOptions(options)
          else
            $('#post_image').val('')
            alert 'Загружаемое вами изображение меньше 565х200!'

        img.src = img_src

      reader.readAsDataURL(input.files[0])



