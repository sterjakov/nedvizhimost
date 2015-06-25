# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->


  # Карусель

  if $('#photos').length > 0
    $('#photos').scrollingCarousel()

  # Галлерея


  if $('.fancybox').length > 0
    $(".fancybox").fancybox({
      openEffect	: 'none',
      cyclic      : true,
      closeEffect	: 'none'
    })


  # Яндекс карты

  element = $('#addres_for_map')
  if element.length > 0
    address = element.html()
    init = () ->
      ymaps.geocode(address, results: 1).then (res) ->
        firstGeoObject = res.geoObjects.get(0)
        if firstGeoObject == null
          $('#yandex_map').remove()
        myMap = new ymaps.Map("yandex_map",center:  firstGeoObject.geometry.getCoordinates(), zoom: 16)
        myMap.geoObjects.add(res.geoObjects)
        true
      ,(err)->
        alert(err.message)
        true
      true
    ymaps.ready(init)
    true

  true