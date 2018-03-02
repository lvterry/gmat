#= require jquery
#= require csrf
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

  # config subjects
  $('[name=config-subjects]').on 'click', (e) ->
    arr = []
    $('[name=config-subjects]').each -> arr.push(@value) if @checked
    $('#take_subjects').val arr.join(',')

  # prevent form submission when no subjects configured
  $('#new_take').on 'submit', (e) ->
    if $('[name=config-subjects]').filter(':checked').length is 0
      window.alert '请选择科目'
      return false

  # show hide clock upon click
  $('.exam-main .header .right').on 'click', (e) ->
    $(@).find('.to-hide').toggle()

  $('.js-next-exercise').on 'click', (e) ->
    e.preventDefault()
    if $('.multi-choice-list input:checked').length is 0
      $('.js-unanwsered').show()
      return false
    else
      $('.js-confirm-anwser').show()

  $('.btn-skip').on 'click', (e) ->
    url = @getAttribute 'data-url'
    takeId = @getAttribute 'data-take-id'
    #examId = @getAttribute 'data-exam-id'
    $.ajax
      url: "/takes/#{takeId}"
      method: 'PATCH'
      data:
        currentTimestamp: Date.now()
        #examId: examId
      success: (data) -> window.location = url

  $('.js-confirm-anwser-yes').on 'click', (e) ->
    url = @getAttribute 'data-url'
    takeId = @getAttribute 'data-take-id'
    examId = @getAttribute 'data-exam-id'
    exerciseId = @getAttribute 'data-exercise-id'
    minutes = $('#clock .minutes').text()
    seconds = $('#clock .seconds').text()
    $.ajax
      url: "/takes/#{takeId}"
      method: 'PATCH'
      data:
        thisAnwser: $('[name=choice]:checked').val()
        timeLeft: "#{minutes}:#{seconds}"
        currentTimestamp: Date.now()
        examId: examId
        exerciseId: exerciseId
      success: (data) ->
        if url.indexOf("-1") is -1
          window.location = url
        else
          window.location = "/exams/#{examId}/result?take_id=#{takeId}"

  $('.js-end-exam').on 'click', (e) ->
    e.preventDefault()
    $('.js-end-exam-dialog').show()

  $('.dialog-close, .dialog .close').on 'click', (e) ->
    e.preventDefault()
    $(this).parents('.dialog').hide()

  $('.js-yes').on 'click', (e) ->
    e.preventDefault()
    window.location = '/exams'

  $('.js-pause-exam-btn').on 'click', (e) ->
    btn = $(@)
    if btn.find('u').text() is "P"
      btn.html '<span><u>R</u>esume Exam</span>'
    else
      btn.html '<span><u>P</u>ause Exam</span>'
    $('.pause-exam-content').toggle()
    $('.exercise-content').toggle()

  # if the page contains countdown
  if document.getElementById('clock')
    clock = new Clock(document.getElementById('clock'))
    clock.start()
