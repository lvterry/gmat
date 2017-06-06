#= require swiper.jquery
#= require moment.min
#= require fullcalendar.min

class EventsFilter
  constructor: (@calendar)->
    @selectedIndex = -1
    @inputs = $('[name=calendar-category]')
    @inputs.on 'click', @changeCategory
    @loadEvents({})

  changeCategory: (e)=>
    input = e.currentTarget
    if input.value != @selectedIndex
      @selectedIndex = input.value
      @loadEvents {category: @selectedIndex}

  loadEvents: (data) =>
    @layerIndex = layer.msg '加载中...', { time: 0 }
    $.ajax
      url: '/meetings.json'
      data: data
      success: (events) =>
        @calendar.fullCalendar('removeEvents')
        @calendar.fullCalendar('addEventSource', events)
        @calendar.fullCalendar('rerenderEvents')
      complete: =>
        layer.close @layerIndex

$ ->

    changeSlideColor = (slide) ->
      if slide is undefined
        slide = $('.swiper-slide').first()
      else
        slide = $('.swiper-slide').eq(slide.activeIndex)
      color = slide.data('color')
      $('.header-margin').css 'background-color', '#' + color

    changeSlideColor()

    swiper = new Swiper '.swiper-container',
      pagination: '.swiper-pagination'
      nextButton: '.swiper-button-next'
      prevButton: '.swiper-button-prev'
      loop: true
      autoplay: 3000

    swiper.on 'slideNextStart', changeSlideColor
    swiper.on 'slidePrevStart', changeSlideColor

    $('#calendar').fullCalendar
      header:
        left: 'prev,next today'
        center: 'title'
        right: 'month,basicWeek,basicDay'
      defaultDate: new Date()
      firstDay: 1
      navLinks: true
      editable: false
      eventLimit: true
      eventBorderColor: '#fff'
      timeFormat: 'H:mm'

    new EventsFilter $('#calendar')