#= require jquery
#= require rAF
#= require js.cookie
#= require countdown.min

class Clock
  constructor: (@el) ->
    @minutes = @el.querySelector '.minutes'
    @seconds = @el.querySelector '.seconds'

    if Cookies.get('myClock')
      @deadline = Cookies.get('myClock')
    else
      @deadline = @minutes.innerText * 60 * 1000 + (new Date()).getTime()
      Cookies.set('myClock', @deadline, { expires: 1 })

  start: =>
    date = new Date()
    timespan = countdown date, @deadline, countdown.MINUTES|countdown.SECONDS
    @minutes.innerHTML = timespan.minutes
    @seconds.innerHTML = ('0' + timespan.seconds).slice(-2)
    requestAnimationFrame @start, 60

$ ->

  $('.js-next-exercise').on 'click', (e) ->
    e.preventDefault()
    if $('.multi-choice-list input:checked').length is 0
      $('.js-unanwsered').show()
      return false
    else
      $('.js-confirm-anwser').show()

  $('.js-end-exam').on 'click', (e) ->
    e.preventDefault()
    $('.js-end-exam-dialog').show()

  $('.dialog-close, .dialog .close').on 'click', (e) ->
    $(this).parents('.dialog').hide()

  $('.js-yes').on 'click', (e) ->
    e.preventDefault()
    window.location = '/exams'

  $('.js-pause-exam-btn').on 'click', (e) ->
    btn = $(@)
    if btn.find('u').text() is "P"
      btn.html '<span><u>R</u>esume Exam</span>'
    else
      console.log btn.find('u').text()
      btn.html '<span><u>P</u>ause Exam</span>'
    $('.pause-exam-content').toggle()
    $('.exercise-content').toggle()

  clock = new Clock(document.getElementById('clock'))
  clock.start()

