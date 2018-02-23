#= require plotly-basic.min

$ ->

  timeAnalysisChart = document.getElementById('time-chart')
  timeMgmt = document.getElementById('subsection-time-mgmt')
  rightWrong = document.getElementById('subsection-right-wrong')
  #subjects = ['RC', 'CR', 'SC', 'Overall']

  hideModeBar = { displayModeBar: false }

  drawTimesChart = (times)->

    data =
      x: [1..times.length]
      y: times
      mode: 'lines+markers'
    layout0 =
      xaxis:
        fixedrange: true
      yaxis:
        autorange: true
        rangemode: 'tozero'
      autosize: false
      height: 350
      width: 1090
      margin:
        l: 50
        r: 50
        b: 50
        t: 20
        pad: 4
    trace = [data]
    Plotly.newPlot(timeAnalysisChart, trace, layout0, hideModeBar)

  drawTimeMgmtChart = (data, subjects) ->
    trace =
      y: subjects
      x: data
      type: 'bar'
      orientation: 'h'
      marker:
        color: '#3366cc'

    layout1 =
      xaxis:
        fixedrange: true
      yaxis:
        fixedrange: true
      autosize: false
      height: 300
      width: 500
      margin:
        l: 50
        r: 50
        b: 100
        t: 20
        pad: 4

    Plotly.newPlot(timeMgmt, [trace], layout1, hideModeBar)

  drawRightWrongChart = (r, w, subjects) ->
    wrong =
      x: w,
      y: subjects
      name: 'Wrong',
      orientation: 'h',
      marker: {
        color: '#dd4477',
        width: 1
      },
      type: 'bar'

    right =
      x: r,
      y: subjects
      name: 'Right',
      orientation: 'h',
      marker: {
        color: '#66aa00',
        width: 1
      },
      type: 'bar'

    data = [wrong, right]

    layout2 =
      xaxis:
        fixedrange: true
      yaxis:
        fixedrange: true
      autosize: false
      height: 300
      width: 560
      margin:
        l: 50
        r: 50
        b: 100
        t: 20
        pad: 4
      barmode: 'stack'

    Plotly.newPlot(rightWrong, data, layout2, hideModeBar)



  getSubjects = (type) ->
    if type is 'verbal'
      ['RC', 'CR', 'SC', 'Overall']
    else
      ['PS', 'DS', 'Overall']

  # init charts
  drawTimesChart verbalTimes
  drawTimeMgmtChart verbalTimeManagementData, getSubjects('verbal')
  drawRightWrongChart verbalRightData, verbalWrongData, getSubjects('verbal')

  # switch exercise details
  exerciseNumbers = $('.exercise-numbers a')
  takeId = $('.exercise-numbers').attr 'data-take-id'
  exerciseNumbers.on 'click', (e) ->
    e.preventDefault()
    unless $(@).hasClass 'current'
      exerciseNumbers.removeClass 'current'
      $(@).addClass 'current'
      exerciseId = $(@).attr 'data-ex-id'
      anwserIndex = $(@).attr 'data-index'
      getExercise exerciseId, anwserIndex

  getExercise = (exerciseId, anwserIndex) ->
    $.get
        url: "/exercises/#{exerciseId}.js"
        dataType: 'script'
        data:
          take_id: takeId
          anwser_index: anwserIndex
          exercise_id: exerciseId

  getFirstExercise = ->
    exerciseId = exerciseNumbers[0].getAttribute 'data-ex-id'
    anwserIndex = exerciseNumbers[0].getAttribute 'data-index'
    getExercise exerciseId, anwserIndex

  getFirstExercise()

  # switch subjects
  subjectSwitch = $('.js-exercise-switch a')
  tabs = $('.js-tab')
  subjectSwitch.on 'click', (e) ->
    e.preventDefault()
    unless $(@).hasClass('active')
      subjectSwitch.removeClass 'active'
      $(@).addClass 'active'
      tabs.hide()
      tabs.filter("[data-tab='#{@hash.replace('#','')}']").show().find('a').first().click()

  $('.js-time-chart-switch a').on 'click', (e) ->
    e.preventDefault()
    unless $(@).hasClass('active')
      $('.js-time-chart-switch a').removeClass('active')
      $(@).addClass 'active'
      if @hash is '#verbal'
        drawTimesChart verbalTimes
        drawTimeMgmtChart verbalTimeManagementData, getSubjects('verbal')
        drawRightWrongChart verbalRightData, verbalWrongData, getSubjects('verbal')
      else
        drawTimesChart quantTimes
        drawTimeMgmtChart quantTimeManagementData, getSubjects('quant')
        drawRightWrongChart quantRightData, quantWrongData, getSubjects('quant')



