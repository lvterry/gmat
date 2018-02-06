#= require jquery
#= require csrf
#= require rAF
#= require js.cookie
#= require countdown.min

class BreakClock
  constructor: (@el) ->
    @minutes = @el.querySelector '.minutes'
    @seconds = @el.querySelector '.seconds'
    takeId = @el.getAttribute 'data-take-id'
    cookieId = 'breakClock' + takeId

    if Cookies.get(cookieId)
      @deadline = Cookies.get(cookieId)
    else
      @deadline = @minutes.innerText * 60 * 1000 + (new Date()).getTime()
      Cookies.set(cookieId, @deadline, { expires: 1 })

  start: =>
    date = new Date()
    timespan = countdown date, @deadline, countdown.MINUTES|countdown.SECONDS
    @minutes.innerHTML = timespan.minutes
    @seconds.innerHTML = ('0' + timespan.seconds).slice(-2)

    if (new Date()).getTime() >= @deadline
      cancelAnimationFrame @start
      window.location  = $('#break-link').attr('href')

    requestAnimationFrame @start, 60

$ ->
  # if the page contains countdown
  if document.getElementById('break-clock')
    clock = new BreakClock(document.getElementById('break-clock'))
    clock.start()
