#= require echarts.common.min

percentCorrectData = null

initVideoGuide = ()->
  videos = $('.polyv')
  return if videos.length is 0
  element = videos.first()
  player = polyvObject(element).videoPlayer
    'width': '840'
    'height': '573'
    'vid': element.attr('id')

$ ->
  drawTimesChart = (times)->
    myChart = echarts.init(document.getElementById('time-chart'))
    option =
      grid:
        top: 30
        left: 30
        right: 20
      tooltip:
        trigger: 'axis'
        formatter: '题目{b}用时: {c}秒'
      xAxis:
        type: 'category'
        data: [1..times.length]
      yAxis:
        type: 'value'
      series: [{
          data: times
          type: 'line'
          lineStyle:
            color: '#00B9FC'
            width: 2
          itemStyle:
            color: '#00B9FC'
            borderWidth: 2
          symbolSize: 8

      }]
    myChart.setOption(option)

  drawTimeMgmtChart = (data, subjects) ->
    myChart = echarts.init(document.getElementById('subsection-time-mgmt'))
    option =
      grid:
        top: 10
      xAxis:
        type: 'value'
      yAxis:
        type: 'category'
        data: subjects
      series: [{
        data: data
        type: 'bar'
        itemStyle:
          color: '#00B9FC'
        label:
          normal:
            formatter: (params) ->
              if params.value > 0 then Math.round(params.value * 100) / 100 + '"' else ''
            show: true
            position: 'insideRight'
      }]
    myChart.setOption(option)

  drawRightWrongChart = (r, w, subjects) ->
    myChart = echarts.init(document.getElementById('subsection-right-wrong'))
    option =
      tooltip:
        trigger: 'axis'
        axisPointer:
          type: 'shadow'
        formatter: (params) ->
          text = "<b>#{params[0].name}</b><br/>"
          text += params[0].marker + params[0].seriesName + ': ' + Math.ceil(params[0].value * 100) + '%' + '<br/>'
          text += params[1].marker + params[1].seriesName + ': ' + Math.ceil(params[1].value * 100) + '%' + '<br/>'
          text
      grid:
        top: 10
      xAxis:
        type: 'value'
      yAxis:
        type: 'category'
        data: subjects
      series: [{
        name: 'Wrong'
        type: 'bar'
        data: w
        stack: 'total'
        label:
          normal:
            formatter: (params) ->
              if params.value > 0 then Math.ceil(params.value * 100) + '%' else ''
            show: true
            position: 'insideRight'
        itemStyle:
          color: '#E90074'
      }, {
        name: 'Right'
        type: 'bar'
        data: r
        stack: 'total'
        label:
          normal:
            formatter: (params) ->
              if params.value > 0 then Math.ceil(params.value * 100) + '%' else ''
            show: true
            position: 'insideRight'
        itemStyle:
          color: '#00B9FC'
      }]
    myChart.setOption(option)


  getSubjects = (type) ->
    if type is 'verbal'
      ['RC', 'CR', 'SC', 'Overall']
    else
      ['PS', 'DS', 'Overall']

  # init charts
  if verbalTimes?
    drawTimesChart verbalTimes
    drawTimeMgmtChart verbalTimeManagementData, getSubjects('verbal')
    drawRightWrongChart verbalRightData, verbalWrongData, getSubjects('verbal')
  else
    drawTimesChart quantTimes
    drawTimeMgmtChart quantTimeManagementData, getSubjects('quant')
    drawRightWrongChart quantRightData, quantWrongData, getSubjects('quant')

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
        success: initVideoGuide

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
        drawDiagram percentCorrectData.verbal
      else
        drawTimesChart quantTimes
        drawTimeMgmtChart quantTimeManagementData, getSubjects('quant')
        drawRightWrongChart quantRightData, quantWrongData, getSubjects('quant')
        drawDiagram percentCorrectData.quant

  # percent correct
  getPercentData(takeId)

getPercentData = (takeId) ->
  $.get
    url: "#{window.location.pathname}.json"
    dataType: 'json'
    data:
      take_id: takeId
    success: (data) ->
      percentCorrectData = data
      drawDiagram data.verbal

drawDiagram = (data) ->
  diagramContainer = $('.percent-correct-diagram .right')
  diagramContainer.empty()
  document = window.document
  for section, i in data
    sec = document.createElement('div')
    sec.className = 'section'
    blackBar = document.createElement('div')
    blackBar.className = 'black-bar'
    if i is 0
      blackBar.innerText = 'first'
    else if i is data.length - 1
      blackBar.innerText = 'last'
    else if i is 1
      blackBar.innerText = 'second'
    else if i is 2
      blackBar.innerText = 'third'
    else if i is 3
      blackBar.innerText = 'fourth'
    barCorrect = document.createElement('div')
    barCorrect.className = 'bar-correct'
    barCorrect.innerText = "#{Math.ceil(section.correct)}%"
    barCorrect.style = "height: #{section.correct * 2}px; line-height: #{section.correct * 2}px;"
    barIncorrect = document.createElement('div')
    barIncorrect.className = 'bar-incorrect'
    barIncorrect.innerText = "#{Math.ceil(section.incorrect)}%"
    barIncorrect.style = "height: #{section.incorrect * 2}px; line-height: #{section.incorrect * 2}px;"
    sec.appendChild blackBar
    sec.appendChild barCorrect
    sec.appendChild barIncorrect
    diagramContainer.append sec
  if data.length < 5
    emptySec = document.createElement('div')
    emptySec.className = 'section'
    blackBar = document.createElement('div')
    blackBar.className = 'black-bar'
    blackBar.innerHTML = '&nbsp;'
    emptySec.appendChild blackBar
    diagramContainer.append emptySec


  $('.js-tab input[type=radio]').on 'click', (e) ->
    $(this).parents('.js-tab').find('.exercise-numbers li a').hide()

    if $(this).val() == 'all'
      $('.exercise-numbers li a').show()
    else if $(this).val() == 'sc'
      $(".exercise-numbers li a[data-label='语法SC']").show()
    else if $(this).val() == 'cr'
      $(".exercise-numbers li a[data-label='逻辑CR']").show()
    else if $(this).val() == 'rc'
      $(".exercise-numbers li a[data-label='阅读RC']").show()
    else if $(this).val() == 'ps'
      $(".exercise-numbers li a[data-label='数学PS']").show()
    else if $(this).val() == 'ds'
      $(".exercise-numbers li a[data-label='数学DS']").show()
    else if $(this).val() == 'wrong'
      $(".exercise-numbers li a.wrong").show()
    else if $(this).val() == 'longtime'
      $(".exercise-numbers li a[data-longtime='true']").show()
