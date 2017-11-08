#= require jquery
#= require countdown.min

class Clock
  constructor: (@deadline, @el) ->
    @minutes = @el.querySelector '.minutes'
    @seconds = @el.querySelector '.seconds'

  start: ->
    currentTime = Date.parse(new Date())
    deadline = new Date(currentTime + @deadline * 60 * 1000)

    @timer = setInterval =>
      t = @getTimeRemaining(deadline)
      @updateDisplay(t.minutes, t.seconds)
      clearInterval(@timer) if t.total < 0
    , 1000
    @updateDisplay(@deadline, '00')

  updateDisplay: (m, s)->
    @minutes.innerText = m
    @seconds.innerText = ('0' + s).slice(-2)

  getTimeRemaining: (endtime) ->
    t = Date.parse(endtime) - Date.parse(new Date())
    seconds = Math.floor( (t/1000) % 60 )
    minutes = Math.floor( (t/1000/60) % 60 )
    hours = Math.floor( (t/(1000*60*60)) % 24 )
    days = Math.floor( t/(1000*60*60*24) )
    return {
      'total': t
      'days': days
      'hours': hours
      'minutes': minutes
      'seconds': seconds
    }

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

  clock = new Clock(75, document.getElementById('clock'))
  clock.start()

