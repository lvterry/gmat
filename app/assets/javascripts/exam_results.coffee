#= require plotly-basic.min

$ ->

  timeAnalysisChart = document.getElementById('time-chart')
  timeMgmt = document.getElementById('subsection-time-mgmt')
  rightWrong = document.getElementById('subsection-right-wrong')

  hideModeBar = { displayModeBar: false }

  data =
    x: [1..times.length]
    y: times
  layout0 =
    xaxis:
      fixedrange: true
    yaxis:
      fixedrange: true
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
  Plotly.plot(timeAnalysisChart, trace, layout0, hideModeBar)

  trace =
    y: ['Overall', 'SC', 'CR', 'RC']
    x: [12, 24, 18, 20]
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

  Plotly.plot(timeMgmt, [trace], layout1, hideModeBar)

  trace1 = 
    x: [20, 14, 23, 11],
    y: ['Overall', 'SC', 'CR', 'RC']
    name: 'Wrong',
    orientation: 'h',
    marker: {
      color: '#dd4477',
      width: 1
    },
    type: 'bar'

  trace2 =
    x: [12, 17, 19, 21],
    y: ['Overall', 'SC', 'CR', 'RC']
    name: 'Right',
    orientation: 'h',
    marker: {
      color: '#66aa00',
      width: 1
    },
    type: 'bar'

  data = [trace1, trace2]

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

  getFirstExercise = ->
    exerciseId = exerciseNumbers[0].getAttribute 'data-ex-id'
    anwserIndex = exerciseNumbers[0].getAttribute 'data-index'
    getExercise exerciseId, anwserIndex

  getFirstExercise()


