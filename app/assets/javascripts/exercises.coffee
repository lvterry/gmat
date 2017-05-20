#= require url-search-params

$ ->
  exerciseFilters = $('.exercise-filters a')
  selectedFilters = $('.selected-filters a')
  searchParams = new URLSearchParams(location.search)

  exerciseFilters.on 'click', (e) ->
    e.preventDefault()
    labelId = $(@).data('value')
    labels = if searchParams.get('labels') then searchParams.get('labels').split(',') else []
    labels.push labelId
    searchParams.set 'labels', labels.join(',')
    setPathname(searchParams)

  selectedFilters.on 'click', (e) ->
    e.preventDefault()
    labelId = $(@).data('value')
    labels = searchParams.get('labels').split(',')
    newLabels = []
    labels.forEach (item) ->
      newLabels.push(item) if item isnt "#{labelId}"
    searchParams.set 'labels', newLabels

    setPathname(searchParams)

  setPathname = (searchParams) ->
    pathname = if (location.pathname.indexOf('search') is -1) then "#{location.pathname}/search" else location.pathname
    window.location = "#{pathname}?#{searchParams.toString()}"

  # intercept search form post
  # so that filters are submitted too
  $('.search-bar form').on 'submit', (e)->
    console.log e
    if searchParams.has('labels')
      console.log "I need to be submitted"
    #return false


  $('.show-guides').on 'click', (e) ->
    $('.guides').toggle()