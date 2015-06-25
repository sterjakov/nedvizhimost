// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//

//= require jquery
//= require jquery_ujs
//= require search
//= require realty_sell_change
//= require house_photo
//= require scrollingcarousel.2.0
//= require houses
//= require jquery.fancybox-1.3.4
//= require jquery.mousewheel-3.0.4.pack

$(function(){

    var source_link = '<p>Оригинал статьи: <a href="' + location.href + '">' + location.href + '</a></p>';

    if (window.getSelection) $('.description p').bind(
        'copy',
        function()
        {
            var selection = window.getSelection();
            var range = selection.getRangeAt(0);

            var magic_div = $('<div>').css({ overflow : 'hidden', width: '1px', height : '1px', position : 'absolute', top: '-10000px', left : '-10000px' });
            magic_div.append(range.cloneContents(), source_link);
            $('body').append(magic_div);

            var cloned_range = range.cloneRange();
            selection.removeAllRanges();

            var new_range = document.createRange();
            new_range.selectNode(magic_div.get(0));
            selection.addRange(new_range);

            window.setTimeout(
                function()
                {
                    selection.removeAllRanges();
                    selection.addRange(cloned_range);
                    magic_div.remove();
                }, 0
            );
        }
    );



    // Поиск

    var search_speed = 300

    // Открыть
    $('body').delegate('.custom_search','click', function(){
        $('.description > .search').slideDown(search_speed)
        $(this).removeClass('custom_search blue')
        $(this).html('cкрыть поиск')
        $(this).addClass('close_custom_search')
        $('.search_icon').css('display','none')
    })

    // закрыть
    $('body').delegate('.close_custom_search','click', function(){
        $('.description > .search').slideUp(search_speed)
        $(this).removeClass('close_custom_search')
        $(this).html('Расширенный поиск')
        $(this).addClass('custom_search blue')
        $('.search_icon').css('display','block')
    })



    // Назначаем выпадающее меню там где оно должно быть
    $('#menu > div > ul > li').each(function(){
        if ($(this).children('ul').length > 0) {
            $(this).addClass('drop')
        }
    })

    // Скроллинг меню
    /* $(window).scroll(function() {
        if($(window).scrollTop() > 85) {
            $("#menu").css({'top':'0','position':'fixed', 'z-index':'2', 'margin-top':'5px'});
            open_extend_menu(true)
            $(".ext-menu").css({'opacity':'0.7'})
        } else {
            if($("#menu").css('position') == 'fixed') $("#menu").css({'position':'relative', 'margin-top':'0px'});
            $(".ext-menu").css({'opacity':'1'})
            open_extend_menu(false)
        }
    });

    // true - появление / false - исчезнвоение
    function open_extend_menu(action) {

        var extend_menu_speed = 300;

        $('#menu .extend').stop()

        if (action == true) {
            $('#menu .extend').animate({'marginTop':'52px'}, extend_menu_speed, function(){
                $('.extend .show').animate({opacity:'1'},300);
            })
        } else {
            $('#menu .extend').animate({'marginTop':'29px'}, extend_menu_speed, function(){
                $('.extend .show').animate({opacity:'0'},300);
            })
        }
    }

    // Кнопка наверх
    $('.scroll_up').click(function(){
        $("html, body").animate({ scrollTop: 0 }, 300);
    }) */

    // Модальное окно

    var modal_speed = 400

    // true - появление / false - исчезнвоение
    function modal_open(action) {

        var top_percent

        if (action == true) {
            $('.modal .window').css('display','block')
            top_percent = '50%'
            $('.modal .window').animate({ top: top_percent }, modal_speed)
        } else {
            top_percent = '-50%'
            $('.modal .window').animate({ top: top_percent }, modal_speed, function(){
                $('.modal .window').css('display','none')
            })
        }

    }

    // Тень
    // true - появление / false - исчезнвоение
    function shadow_open(action) {

        var opacity_int

        if (action == true) {
            $('.shadow').css('display','block')
            opacity_int = '0.5'
            $('.shadow').animate({ opacity: opacity_int }, modal_speed)
        } else {
            opacity_int = '0'
            $('.shadow').animate({ opacity: opacity_int }, modal_speed, function(){
                $('.shadow').css('display','none')
            })
        }

    }


    // Только первый клик по "Заказать обратный звонок"
    $('.button-menu, .zakazat_zvonok_eksperta').one("click",function(){
        $.ajax({ url: '/main/contact_form' }).done(function(html){
            $('.phone-order > .offset').append(html)
        })
    })

    // Клик по "Заказать обратный звонок"
    $('.button-menu, .zakazat_zvonok_eksperta').click(function(){
        shadow_open(true)
        modal_open(true)
    })

    // Кнопка закрыть окно / закрыть при клике на тень
    $('.close, .shadow').click(function(){
        shadow_open(false)
        modal_open(false)
    })




})