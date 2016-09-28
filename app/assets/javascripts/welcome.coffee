#= require swiper.jquery
#= require moment.min
#= require fullcalendar.min

$ ->
    barcode = $('#barcode')
    $('#wechat').on 'click', (e)->
      barcode.toggle();
      e.stopPropagation();
      $('body').one 'click', -> barcode.hide()

    changeSlideColor = (slide) ->
      if slide is undefined
        slide = $('.swiper-slide').first()
      else
        slide = $('.swiper-slide').eq(slide.activeIndex)
      color = slide.data('color')
      $('.header-margin').css 'background-color', color

    changeSlideColor()

    swiper = new Swiper '.swiper-container',
      pagination: '.swiper-pagination'
      nextButton: '.swiper-button-next'
      prevButton: '.swiper-button-prev'
      loop: true

    swiper.on 'slideNextStart', changeSlideColor
    swiper.on 'slidePrevStart', changeSlideColor

    initCalendar()

window.initCalendar = ->
  $('#calendar').fullCalendar
    header:
      left: 'prev,next today'
      center: 'title'
      right: 'month,basicWeek,basicDay'
    defaultDate: '2016-09-25'
    firstDay: 1
    navLinks: true
    editable: false
    eventLimit: true
    events: '/meetings.json'
    eventBorderColor: '#fff'