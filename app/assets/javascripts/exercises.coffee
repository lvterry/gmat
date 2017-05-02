$ ->
  exerciseFilters = $('.exercise-filters')

  ['book', 'subject', 'difficulty'].forEach (item) ->
    if filters[item] isnt undefined
      exerciseFilters.find(".js-#{item} a").each ->
        $(@).addClass('selected') if $(@).text() is filters[item]

  $('.selected-filters a').click (e)->
    e.preventDefault()
    key = $(@).data 'label'
    delete filters[key]
    filterResults()

  $('.exercise-filters a').click (e)->
    e.preventDefault()
    key = $(@).parent().data 'label'
    filters[key] = $(@).text()
    filterResults()


filterResults = ->
    window.location = window.location.pathname + '?filters=' + JSON.stringify(filters)

