$ ->
  exerciseFilters = $('.exercise-filters')

  ['book', 'subject', 'difficulty'].forEach (item) ->
    if (filters isnt null) and (filters[item] isnt undefined)
      exerciseFilters.find(".js-#{item} a").each ->
        $(@).addClass('selected') if $(@).text() is filters[item]

  $('.selected-filters a').click (e)->
    e.preventDefault()
    key = $(@).data 'label'
    delete window.filters[key]
    filterResults()

  $('.exercise-filters a').click (e)->
    e.preventDefault()
    filters = window.filters
    key = $(@).parent().data 'label'
    filters ?= {}
    filters[key] = $(@).text()
    window.filters = filters
    filterResults()


filterResults = ->
  pathname = window.location.pathname
  pathname = "#{pathname}/search" if pathname.indexOf('search') is -1
  window.location = pathname + '?filters=' + JSON.stringify(window.filters)

