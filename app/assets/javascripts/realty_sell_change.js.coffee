# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->

  # Смена каталогов Аренды и Продажи

  hidden_field = (obj) ->
    if $('.hidden_fields.active').length < 1
      $('.hidden_fields').addClass('active')

  $('body').delegate '#add_house #house_fields_type', 'change', (event) ->
    select = $(this).find('option:selected').attr('value')
    if select == '2'
      $('.rent_fields').addClass('active')
      $('.sell_fields').removeClass('active')
      action_url = $('#add_house form').attr('action').replace("sell", "rent")
      $('#add_house form').attr('action', action_url)
      $('.catalog_title').html('Аренда недвижимости')
      $('#house_realty_type').attr('value',2)
      hidden_field()
    else if select == '1'
      $('.sell_fields').addClass('active')
      $('.rent_fields').removeClass('active')
      action_url = $('#add_house form').attr('action').replace("rent", "sell")
      $('#add_house form').attr('action', action_url)
      $('.catalog_title').html('Продажа недвижимости')
      $('#house_realty_type').attr('value',1)
      hidden_field()