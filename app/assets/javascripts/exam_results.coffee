#= require echarts.common.min

$ ->
  drawTimesChart = (times)->
    myChart = echarts.init(document.getElementById('time-chart'))
    option =
      grid:
        top: 30
        left: 30
        right: 20
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



