# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



jQuery ->
  $('#menu li').hover(
    -> $(this).children('div').css('display','block'),
    -> $(this).children('div').css('display','none')
  )

  hidden_field = (obj) ->
    if $('.hidden_fields.active').length < 1
      $('.hidden_fields').addClass('active')

  $('body').delegate '#add_house #house_fields_type', 'change', (event) ->
    select = $(this).find('option:selected').attr('value')
    console.log select
    if select == '2'
      $('.rent_fields').addClass('active')
      $('.sell_fields').removeClass('active')
      action_url = $('form').attr('action').replace("sell", "rent")
      $('form').attr('action', action_url)
      $('h1').html('Каталог аренды')
      hidden_field()
    else if select == '1'
      $('.sell_fields').addClass('active')
      $('.rent_fields').removeClass('active')
      action_url = $('form').attr('action').replace("rent", "sell")
      $('form').attr('action', action_url)
      $('h1').html('Каталог продажи')
      hidden_field()






